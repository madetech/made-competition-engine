require 'competition/engine'
require Competition::Engine.root.join('app', 'validators', 'competition')
require 'stringex'

module Competition
  mattr_accessor :cache_sweeper
  @@cache_sweeper = false

  mattr_accessor :image_styles
  @@image_styles = {
    :main => "466x377#",
    :secondary => "231x150#",
    :mobile => "150x150#",
    :thumb => "70x70#"
  }

  mattr_accessor :engine_routing
  @@engine_routing = true

  mattr_accessor :engine_active_admin
  @@engine_active_admin = true

  mattr_accessor :competition_item_entry_class
  @@competition_item_entry_class = false

  mattr_accessor :competition_item_class
  @@competition_item_class = false

  class Engine < Rails::Engine
    isolate_namespace Competition

    initializer :competition do
      ActiveAdmin.application.load_paths.unshift Dir[Competition::Engine.root.join('app', 'admin')] if defined?(ActiveAdmin)
    end

    ActiveModel::Validations.__send__(:include, Competition::CompetitionValidators)
  end

  def self.config(&block)
    yield self if block

    return self
  end
end
