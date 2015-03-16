$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "teaspoon/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "teaspoon"
  s.version     = Teaspoon::VERSION
  s.authors     = ["jejacks0n", "jayzes", "jedschneider", "mikepack"]
  s.email       = ["info@modeset.com"]
  s.homepage    = "https://github.com/modeset/teaspoon"
  s.summary     = "Teaspoon: A Javascript test runner built on top of Rails"
  s.description = ["Run Javascript tests using Jasmine, Mocha or QUnit in the browser",
                   "or headless using PhantomJS, Selenium Webdriver, or Capybara Webkit"].join(" ")
  s.license     = "MIT"

  s.files       = Dir["{app,config,lib,bin}/**/*"] + ["MIT.LICENSE", "README.md"]
  s.test_files  = `git ls-files -- {spec}/*`.split("\n")
  s.executables = ["teaspoon"]

  s.add_dependency "railties", [">= 3.2.5", "< 5"]
end
