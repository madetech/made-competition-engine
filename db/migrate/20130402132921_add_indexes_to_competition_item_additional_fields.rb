class AddIndexesToCompetitionItemAdditionalFields < ActiveRecord::Migration
  def change
    add_index :competition_item_additional_fields, :competition_item_id
  end
end
