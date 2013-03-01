class FixCompetitionAdditionalFields < ActiveRecord::Migration
  def change
  	rename_table :competition_item_aditional_fields, :competition_item_additional_fields
  	rename_table :competition_item_entry_aditional_fields, :competition_item_entry_additional_fields
  	add_column :competition_item_additional_fields, :item_id, :integer
  	rename_column :competition_item_additional_fields, :type, :field_type
  end
end
