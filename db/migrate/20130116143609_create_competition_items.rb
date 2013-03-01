class CreateCompetitionItems < ActiveRecord::Migration
  def change
    create_table :competition_items do |t|
      t.string :title

      t.timestamps
    end
  end
end
