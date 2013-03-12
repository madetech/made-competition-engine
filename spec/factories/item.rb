require 'faker'

FactoryGirl.define do
  factory :item, class: Competition::Item do |f|
    f.title 				{ Faker::Name.title }
    f.url 					{ Faker::Lorem.characters(char_count = 32) }
    f.description 			{ Faker::Lorem.sentence(word_count = 6, supplemental = false) }
    #f.title 				{ "This is a title" }
    #f.slug 				{ "this-is-a-title" }
    #f.description 			{ "This is just a title description" }
    f.start_at 				{ Time.now-3.months }
    f.end_at 				{ Time.now+3.months }
    f.image_file_name 		{ "image.jpg" }
    f.image_content_type 	{ "image/jpg" }
    f.image_file_size 		{ "12345" }
    f.image_updated_at 		{ "2013-01-01 00:00:00" }
  end
end
