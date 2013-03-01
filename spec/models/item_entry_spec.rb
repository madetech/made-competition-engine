require 'spec_helper'

describe "Competition::ItemEntry" do

	before(:each) do
		@item = FactoryGirl.create(:item)
		@item_entry = FactoryGirl.create(:item_entry)
	end

	it "should save valid item entry" do
		item_entry = FactoryGirl.build(:item_entry, competition_item_id: @item.id)
		item_entry.save
		#---
		item_entry.should be_valid
	end

	it "should not accept multiple entries for same email and competition entry" do
		item_entry1 = FactoryGirl.build(:item_entry, email: "test@test.com", competition_item_id: @item.id)
		item_entry1.save
		item_entry2 = FactoryGirl.build(:item_entry, email: "test@test.com", competition_item_id: @item.id)
		item_entry2.save
		#---
		item_entry1.should be_valid
		item_entry2.should_not be_valid
	end

	it "should accept multiple entries for same email but different competition entry" do
		item_entry1 = FactoryGirl.build(:item_entry, email: "test@test.com", competition_item_id: @item.id)
		item_entry1.save
		item_entry2 = FactoryGirl.build(:item_entry, email: "test@test.com", competition_item_id: @item.id+1)
		item_entry2.save
		#---
		item_entry1.should be_valid
		item_entry2.should be_valid
	end

	it "should generate CSV file with all Entries" do
		csv_output = Competition::Item.find(@item.id).populateEntriesCsv
		#---
		csv_output.should match @item_entry.first_name
		csv_output.should match @item_entry.last_name
		csv_output.should match @item_entry.email
	end

end