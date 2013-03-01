module Competition

  class ItemEntryAdditionalField < ActiveRecord::Base

    belongs_to :item_entry, :foreign_key => :competition_item_entry_id
    accepts_nested_attributes_for :item_entry, :allow_destroy => true

    belongs_to :item_additional_field, :foreign_key => :competition_item_additional_field_id
    accepts_nested_attributes_for :item_additional_field, :allow_destroy => true

    attr_accessible :value,
                    :competition_item_entry_id,
                    :competition_item_additional_field_id

    validates_presence_of :value

    def self.create_from_form(item_entry_id, item_entry_additional_field)
    	item_entry_additional_field.each do |item_additional_field_id, value_object|
    		value = value_object[:value]
    		item_entry_additional_field = Competition::ItemEntryAdditionalField.create({
    			:competition_item_entry_id => item_entry_id,
    			:competition_item_additional_field_id => item_additional_field_id,
    			:value => value
    		})
        if !item_entry_additional_field.valid?
          return false
        end
    	end
      return true
    end

  end

end
