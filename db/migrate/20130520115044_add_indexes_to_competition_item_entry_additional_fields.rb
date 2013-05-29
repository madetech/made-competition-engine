class AddIndexesToCompetitionItemEntryAdditionalFields < ActiveRecord::Migration
  def change
    add_index :competition_item_entry_additional_fields, :competition_item_entry_id, :name => 'competition_item_entry_id_index'
  end
end
