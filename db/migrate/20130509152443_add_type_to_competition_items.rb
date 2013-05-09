class AddTypeToCompetitionItems < ActiveRecord::Migration
  def change
    add_column :competition_items, :type, :string
    add_index :competition_items, :type
  end
end
