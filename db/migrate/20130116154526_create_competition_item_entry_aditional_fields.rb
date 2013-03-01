class CreateCompetitionItemEntryAditionalFields < ActiveRecord::Migration
	create_table :competition_item_entry_aditional_fields do |t|
		t.integer :competition_item_id
		t.integer :competition_entry_id
		t.string :value

		t.timestamps
	end
end
