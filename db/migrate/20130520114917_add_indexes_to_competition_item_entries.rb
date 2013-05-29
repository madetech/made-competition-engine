class AddIndexesToCompetitionItemEntries < ActiveRecord::Migration
  def change
    add_index :competition_item_entries, :competition_item_id
  end
end
