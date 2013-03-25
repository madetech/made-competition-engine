require "competition/engine"
require 'stringex'

module Competition
  mattr_accessor :cache_sweeper
  @@cache_sweeper = false

  mattr_accessor :main_item_image_size
  @@main_item_image_size = "466x377#"

  mattr_accessor :secondary_item_image_size
  @@secondary_item_image_size = "231x150#"

  mattr_accessor :mobile_item_image_size
  @@mobile_item_image_size = "150x150#"

  mattr_accessor :item_thumb_size
  @@item_thumb_size = "70x70#"

  mattr_accessor :engine_routing
  @@engine_routing = true

  mattr_accessor :engine_active_admin
  @@engine_active_admin = true

  mattr_accessor :competition_item_entry_class
  @@competition_item_entry_class = false

  class Engine < Rails::Engine
    isolate_namespace Competition

    initializer :competition do
      ActiveAdmin.application.load_paths.unshift Dir[Competition::Engine.root.join('app', 'admin')] if defined?(ActiveAdmin)
    end
  end

  def self.config(&block)
    yield self if block
    return self
  end
end
