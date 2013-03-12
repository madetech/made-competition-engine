require 'spec_helper'

describe "Competition::Item" do

	before(:each) do
		@item = FactoryGirl.create(:item)
	end

	it "has a valid factory" do
		@item.should be_valid
	end

	it "should save valid item" do
		item = FactoryGirl.build(:item)
		item.save
		#---
		item.should be_valid
	end

	it "should fail validation if title is blank" do
		item = FactoryGirl.build(:item, title: "")
		item.save
		#---
		item.should_not be_valid
	end

	it "should fail validation if slug is duplicated" do
		item1 = FactoryGirl.build(:item, slug: "xxx")
		item1.save
		item2 = FactoryGirl.build(:item, slug: "xxx")
		item2.save
		#---
		item1.should be_valid
		item2.should_not be_valid
	end

	it "should create more 2 competitions and have just 1 competition live" do
		item1 = Competition::Item.create(FactoryGirl.attributes_for(:item, start_at: DateTime.now-3.months, end_at: DateTime.now+3.months))
		item2 = Competition::Item.create(FactoryGirl.attributes_for(:item, start_at: DateTime.now+3.months, end_at: DateTime.now+6.months))
		#---
		Competition::Item.all.length.should eq(3)
		Competition::Item.get_all_live_competitions.length.should eq(2)
	end

	it "should be live" do
		item = Competition::Item.create(FactoryGirl.attributes_for(:item, start_at: DateTime.now-3.months, end_at: DateTime.now+3.months))
		item.save
		#---
		item.is_live.should be_true
	end

	it "should not be live" do
		item = Competition::Item.create(FactoryGirl.attributes_for(:item, start_at: DateTime.now+3.months, end_at: DateTime.now+6.months))
		item.save
		#---
		item.is_live.should_not be_true
	end

end
