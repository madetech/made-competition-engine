module Competition

  class ItemAdditionalField < ActiveRecord::Base

    belongs_to                          :item, :foreign_key => :competition_item_id
    accepts_nested_attributes_for       :item, :allow_destroy => true

    has_many                            :item_entry_additional_field,
                                        :foreign_key => :competition_item_additional_field_id
    accepts_nested_attributes_for       :item_entry_additional_field,
                                        :allow_destroy => true

    attr_accessible                     :competition_item_id,
                                        :label,
    				                            :field_type

    validates_presence_of               :label,
                                        :field_type

    def self.sorted_hash(competition_id)
      s_h = Hash.new

      self.field_types.each do |type|
        s_h[type[0].to_sym] = []
      end

      self.where(:competition_item_id => competition_id).each do |field|
        s_h[field.field_type.to_sym] << field
      end

      s_h
    end

    def self.field_types
      [
        ["text"],
        ["checkbox"]
      ]
    end
  end
end
