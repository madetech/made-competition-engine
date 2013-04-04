class AddIndexesToCompetitionItem < ActiveRecord::Migration
  def change
    add_index :competition_items, :url
    add_index :competition_items, :start_at
    add_index :competition_items, :end_at
  end
end
