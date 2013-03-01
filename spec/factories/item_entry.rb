require 'faker'

FactoryGirl.define do
  factory :item_entry, class: Competition::ItemEntry do |f|
    f.first_name            { Faker::Name.first_name }
    f.last_name             { Faker::Name.last_name }
    f.email                 { Faker::Internet.safe_email }
    f.favourite_product     { Faker::Lorem.words(num = 3, supplemental = false) }
    f.address_1             { Faker::Address.street_address }
    f.address_2             { Faker::Address.secondary_address }
    f.city                  { Faker::Address.city }
    f.county                { "Tower Hamlets" }
    f.postcode              { Faker::Address.zip_code }
    f.country               { Faker::Address.country }
    f.promotional_code      { "1234567890" }
    f.competition_item_id   { 1 }
  end
end