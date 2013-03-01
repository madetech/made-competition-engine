module Competition

  class ItemAdditionalField < ActiveRecord::Base

    belongs_to :item, :foreign_key => :competition_item_id
    accepts_nested_attributes_for :item, :allow_destroy => true

    has_many :item_entry_additional_field, :foreign_key => :competition_item_additional_field_id
    accepts_nested_attributes_for :item_entry_additional_field, :allow_destroy => true

    attr_accessible :competition_item_id,
                    :label,
    				        :field_type

    validates_presence_of :label
    validates_presence_of :field_type
    #validates_inclusion_of :field_type, :in => Competition::ItemAdditionalField.field_types

    def self.field_types
      [
        ["text"],
        ["checkbox"]
      ]
    end

  end

end
