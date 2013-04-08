module Competition

  class Item < ActiveRecord::Base
    if Competition.config.engine_routing
      include Competition::Engine.routes.url_helpers
    else
      include Rails.application.routes.url_helpers
    end

    has_many                          :item_entries, :foreign_key => :competition_item_id
    accepts_nested_attributes_for     :item_entries, :allow_destroy => true

    has_many                          :item_additional_fields, :foreign_key => :competition_item_id
    accepts_nested_attributes_for     :item_additional_fields, :allow_destroy => true

    attr_accessible                   :title,
                                      :url,
                                      :description,
                                      :start_at,
                                      :end_at,
                                      :image,
                                      :image_file_name,
                                      :image_content_type,
                                      :image_file_size,
                                      :image_updated_at,
                                      :item_additional_field,
                                      :item_additional_fields_attributes,
                                      :order

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
      if self.item_additional_fields.blank?
        return false
      else
        return true
      end
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
      if self.start_at < DateTime.now and self.end_at > DateTime.now
        return true
      else
        return false
      end
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

    def populateEntriesCsv
      array_output = []

      # Populate Header

      row_header = []
      row_header << "First Name"
      row_header << "Last Name"
      row_header << "email"
      row_header << "Favourite Product"
      row_header << "Address 1"
      row_header << "Address 2"
      row_header << "City"
      row_header << "County"
      row_header << "Postcode"
      row_header << "Country"
      self.item_additional_fields.each do |item_additional_field|
        row_header << item_additional_field.label
      end
      array_output << row_header

      # Populate Content

      self.item_entries.each do |item_entry|
        row_line = []
        row_line << item_entry.first_name
        row_line << item_entry.last_name
        row_line << item_entry.email
        row_line << item_entry.favourite_product
        row_line << item_entry.address_1
        row_line << item_entry.address_2
        row_line << item_entry.city
        row_line << item_entry.county
        row_line << item_entry.postcode
        row_line << item_entry.country
        competition_item_entry_additional_fields = Competition::ItemEntryAdditionalField.find(:all, :conditions => { :competition_item_entry_id => item_entry.id })
        self.item_additional_fields.each do |item_additional_field|
          competition_item_entry_additional_fields.each do |item_entry_additional_field|
            if item_entry_additional_field.competition_item_additional_field_id == item_additional_field.id
              row_line << item_entry_additional_field.value
            end
          end
        end
        array_output << row_line
      end

      # Build CSV

      require 'csv'
      csv_output = CSV.generate do |csv|
        array_output.each do |row|
          csv << row
        end
      end

      return csv_output
    end

  end

end
