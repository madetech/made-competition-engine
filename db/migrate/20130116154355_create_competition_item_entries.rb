class CreateCompetitionItemEntries < ActiveRecord::Migration
	create_table :competition_item_entries do |t|
		t.string :first_name
		t.string :last_name
		t.string :email
		t.string :favourite_product
		t.string :address_1
		t.string :address_2
		t.string :city
		t.string :county
		t.string :postcode
		t.string :country
		t.string :promotional_code

		t.timestamps
    end
end
