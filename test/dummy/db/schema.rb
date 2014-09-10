# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130930084629) do

  create_table "competition_item_additional_fields", :force => true do |t|
    t.integer  "competition_item_id"
    t.string   "label"
    t.string   "field_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "item_id"
  end

  add_index "competition_item_additional_fields", ["competition_item_id"], :name => "index_competition_item_additional_fields_on_competition_item_id"

  create_table "competition_item_entries", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "county"
    t.string   "postcode"
    t.string   "country"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "competition_item_id"
    t.string   "type"
  end

  add_index "competition_item_entries", ["competition_item_id"], :name => "index_competition_item_entries_on_competition_item_id"
  add_index "competition_item_entries", ["type"], :name => "index_competition_item_entries_on_type"

  create_table "competition_item_entry_additional_fields", :force => true do |t|
    t.integer  "competition_item_additional_field_id"
    t.integer  "competition_item_entry_id"
    t.string   "value"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  add_index "competition_item_entry_additional_fields", ["competition_item_entry_id"], :name => "competition_item_entry_id_index"

  create_table "competition_items", :force => true do |t|
    t.string   "title"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.text     "description"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "url"
    t.integer  "order",              :default => 9999
    t.text     "terms"
    t.string   "type"
    t.boolean  "monthly",            :default => false
  end

  add_index "competition_items", ["end_at"], :name => "index_competition_items_on_end_at"
  add_index "competition_items", ["start_at"], :name => "index_competition_items_on_start_at"
  add_index "competition_items", ["type"], :name => "index_competition_items_on_type"
  add_index "competition_items", ["url"], :name => "index_competition_items_on_url"

end
