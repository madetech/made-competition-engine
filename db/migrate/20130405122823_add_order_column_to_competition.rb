class AddOrderColumnToCompetition < ActiveRecord::Migration
  def change
    add_column :competition_items, :order, :integer, :default => 9999
  end
end
