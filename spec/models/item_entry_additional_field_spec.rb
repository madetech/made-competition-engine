require 'spec_helper'

describe "Competition::ItemEntryAdditionalField" do

	before(:each) do
		@item = FactoryGirl.create(:item)
		@item_additional_field1 = Competition::ItemAdditionalField.create({
			:competition_item_id => @item.id,
			:label => "Additional Question 1",
			:field_type => "text"
		})
		@item_additional_field2 = Competition::ItemAdditionalField.create({
			:competition_item_id => @item.id,
			:label => "Additional Question 2",
			:field_type => "checkbox"
		})
		@item_entry = FactoryGirl.create(:item_entry)
	end

	it "should create an user competition entry item with 2 additional fields" do
		item_entry_additional_field = Competition::ItemEntryAdditionalField.create_from_form(@item_entry.id, {
			@item_additional_field1.id => {
				:value => "Additional Answer 1"
			},
			@item_additional_field2.id =>
			{
				:value => 1
			}
		})
		#---
		item_entry_additional_field.should be_true
	end

end