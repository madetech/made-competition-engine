require 'spec_helper'

describe "Competition::ItemAdditionalField" do

	before(:each) do
		@item = FactoryGirl.create(:item)
	end

	it "should create competition item and 2 additional fields" do
		item_additional_field1 = Competition::ItemAdditionalField.create({
			:competition_item_id => @item.id,
			:label => "Additional Question 1",
			:field_type => "text"
		})
		item_additional_field2 = Competition::ItemAdditionalField.create({
			:competition_item_id => @item.id,
			:label => "Additional Question 2",
			:field_type => "checkbox"
		})
		#---
		item_additional_field1.should be_valid
		item_additional_field2.should be_valid
	end

end