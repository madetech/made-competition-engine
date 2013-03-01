class FixCompetitionItemForeignFields < ActiveRecord::Migration
  def change
  	rename_column :competition_item_entry_additional_fields, :competition_item_id, :competition_item_additional_field_id
  	rename_column :competition_item_entry_additional_fields, :competition_entry_id, :competition_item_entry_id
  end
end
