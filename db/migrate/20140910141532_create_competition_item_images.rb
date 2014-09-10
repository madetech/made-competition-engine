class CreateCompetitionItemImages < ActiveRecord::Migration
  def change
    create_table :competition_item_images do |t|
      t.integer :order
      t.references :competition_item

      t.timestamps
    end

    add_attachment :competition_item_images, :image
  end
end
