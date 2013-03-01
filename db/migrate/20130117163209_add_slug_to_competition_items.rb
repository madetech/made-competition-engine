class AddSlugToCompetitionItems < ActiveRecord::Migration
  def change
  	add_column :competition_items, :slug, :string
  end
end
