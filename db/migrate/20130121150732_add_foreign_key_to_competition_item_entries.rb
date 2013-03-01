class AddForeignKeyToCompetitionItemEntries < ActiveRecord::Migration
  def change
  	add_column :competition_item_entries, :competition_item_id, :integer
  end
end
