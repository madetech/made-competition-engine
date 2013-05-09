class AddTypeToCompetitionItemEntries < ActiveRecord::Migration
  def change
    add_column :competition_item_entries, :type, :string
    add_index :competition_item_entries, :type
  end
end
