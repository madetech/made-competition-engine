class DropFavouriteProductAndPromoCode < ActiveRecord::Migration
  def change
    remove_column :competition_item_entries, :favourite_product
    remove_column :competition_item_entries, :promotional_code
  end
end
