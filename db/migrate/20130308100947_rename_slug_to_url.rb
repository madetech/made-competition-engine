class RenameSlugToUrl < ActiveRecord::Migration
  def change
    rename_column :competition_items, :slug, :url
  end
end
