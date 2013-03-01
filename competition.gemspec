$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "competition/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "competition"
  s.version     = Competition::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Competition."
  s.description = "TODO: Description of Competition."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails",       "~> 3.2.11"
  s.add_dependency "paperclip",   "~> 3.0"
  s.add_dependency "country-select"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "shoulda-matchers", "~>1.0"#, "~> 3.0"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "faker"
end
