class AddMonthlyToItem < ActiveRecord::Migration
  def change
    add_column :competition_items, :monthly, :boolean, :default => false
  end
end
