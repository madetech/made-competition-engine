require "competition/engine"

module Competition
  class Engine < Rails::Engine
    isolate_namespace Competition

    initializer :competition do
      ActiveAdmin.application.load_paths.unshift Dir[Competition::Engine.root.join('app', 'admin')] if defined?(ActiveAdmin)
    end
  end

  def self.config(&block)
    @@config ||= Competition::Engine::Configuration.new

    yield @@config if block

    return @@config
  end
end
