require 'csv'

module Competition
  class Item < ActiveRecord::Base
    if Competition.config.engine_routing
      include Competition::Engine.routes.url_helpers
    else
      include Rails.application.routes.url_helpers
    end

    EXPORT_IGNORED_FIELDS = [:updated_at, :competition_item_id, :type]

    has_many                          :item_entries, :foreign_key => :competition_item_id
    accepts_nested_attributes_for     :item_entries, :allow_destroy => true

    has_many                          :item_additional_fields, :foreign_key => :competition_item_id
    accepts_nested_attributes_for     :item_additional_fields, :allow_destroy => true

    attr_accessible                   :title,
                                      :url,
                                      :description,
                                      :start_at,
                                      :end_at,
                                      :monthly,
                                      :image,
                                      :item_additional_field,
                                      :item_additional_fields_attributes,
                                      :order,
                                      :terms

    has_attached_file                 :image, :styles => {
                                        :main => Competition.config.main_item_image_size,
                                        :secondary => Competition.config.secondary_item_image_size,
                                        :mobile => Competition.config.mobile_item_image_size,
                                        :thumb => Competition.config.item_thumb_size
                                      }

    validates                         :title, :presence => true, :uniqueness => true
    validates                         :description, :presence => true
    validates                         :start_at, :presence => true
    validates                         :end_at, :presence => true
    validates                         :image, :presence => true
    validates                         :order, :presence => true

    acts_as_url                       :title

    default_scope                     :order => '`order` ASC'

    def to_param
      url
    end

    def to_s
      title
    end

    def has_additional_fields
      return !self.item_additional_fields.blank?
    end

    def is_entered(entry, additional_fields = nil)
      if self.has_additional_fields
        return (entry.save and Competition::ItemEntryAdditionalField.create_from_form(entry.id, additional_fields))
      else
        return entry.save
      end
    end

    def self.get_all_live_competitions
      self.where("start_at < ? AND end_at > ?", DateTime.now, DateTime.now)
    end

    def is_live
      self.start_at < DateTime.now and self.end_at > DateTime.now
    end

    def get_canonical_url
      competition_new_path(self)
    end

    def get_parent_url
      competition_path
    end

    def get_change_frequency
      "weekly"
    end

    def get_sitemap_priority
      "0.8"
    end

    def get_sitemap_title
      self.title
    end

    def export_entries_as_csv
      # We (very unfortunately) need to drop out of AR at this point for performance reasons.
      results = execute_csv_export

      CSV.generate do |csv|
        csv << get_csv_header
        results.each(:as => :array) do |row|
          csv << row
        end
      end
    end

    private
    def execute_csv_export
      ActiveRecord::Base.connection.execute(get_export_sql)
    end

    def get_csv_header
      csv_header = []
      additional_field_column_headers = get_additional_field_column_headers

      csv_header.concat(get_column_headers_human)
      csv_header.concat(additional_field_column_headers) if additional_field_column_headers.length > 0

      csv_header
    end

    def get_column_headers
      return [] if self.item_entries.length < 1

      column_headers = []
      entry_class = self.item_entries.first.class.name.constantize
      entry_class.column_names.each do |col|
        column_headers << col if !EXPORT_IGNORED_FIELDS.include?(col.to_sym)
      end

      column_headers
    end

    def get_column_headers_human
      get_column_headers.map { |col| col.humanize }
    end

    def get_additional_field_column_headers
      self.item_additional_fields.map { |field| field.label }
    end

    def get_export_sql
      columns = get_export_columns_sql

      """
        SELECT #{columns} #{get_additional_fields_sql} FROM `#{Competition::ItemEntry.table_name}`
        #{get_additional_field_aliases_sql}
        WHERE `#{Competition::ItemEntry.table_name}`.`competition_item_id` = #{self.id}
        GROUP BY `#{Competition::ItemEntry.table_name}`.id
      """
    end

    def get_export_columns_sql
      sql = ""
      after = ", "
      column_headers = get_column_headers
      column_headers.each_with_index do |col, index|
        after = "" if index+1 == column_headers.length
        sql.concat("`#{Competition::ItemEntry.table_name}`.#{col}#{after}")
      end

      sql
    end

    def get_additional_fields_sql
      sql = ""
      before = ", "
      self.item_additional_fields.each_with_index do |field, index|
        after = "" if index == self.item_additional_fields.length
        sql.concat("#{before}additional_field_#{field.id}.value")
      end

      sql
    end

    def get_additional_field_aliases_sql
      sql = ""
      self.item_additional_fields.each do |field|
        sql.concat """
            LEFT JOIN `#{Competition::ItemEntryAdditionalField.table_name}` AS additional_field_#{field.id} ON
            `additional_field_#{field.id}`.`competition_item_entry_id` = `#{Competition::ItemEntry.table_name}`.`id`
            AND `additional_field_#{field.id}`.`competition_item_additional_field_id` = #{field.id}
          """
      end

      sql
    end
  end
end
