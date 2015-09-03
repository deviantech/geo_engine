$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "geo/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "geo"
  s.version     = Geo::VERSION
  s.authors     = ["Kali Donovan"]
  s.email       = ["kali@deviantech.com"]
  # s.homepage    = "TODO"
  s.summary     = "Shareable geo structure from geonames"
  s.description = "Shareable geo structure from geonames: Continent, Country, Region, District, City."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"
  s.add_dependency "responders", "~> 2.1.0"
  s.add_dependency "jbuilder", '~> 2.0'

  s.add_development_dependency "ruby-progressbar", '~> 1.7.5'
  s.add_development_dependency "sqlite3"
end
