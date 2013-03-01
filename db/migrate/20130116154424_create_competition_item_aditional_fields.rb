class CreateCompetitionItemAditionalFields < ActiveRecord::Migration
	create_table :competition_item_aditional_fields do |t|
		t.integer :competition_item_id
		t.string :label
		t.string :type

		t.timestamps
    end
end
