Competition.config do |config|
  config.competition_item_entry_class = Competition::ItemEntry

  config.main_item_image_size = "466x377#"
  config.secondary_item_image_size = "231x150#"
  config.mobile_item_image_size = "150x150#"
  config.item_thumb_size = "70x70#"

  config.engine_active_admin = true
  config.engine_routing = true
end
