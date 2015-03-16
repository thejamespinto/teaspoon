require "teaspoon-devkit"
Teaspoon.require_dummy!

Teaspoon.configure do |config|
  config.asset_paths << path = File.expand_path("../javascripts", __FILE__)
  config.fixture_paths << Teaspoon::FIXTURE_PATH

  config.suite do |suite|
    suite.use_framework :qunit
    suite.matcher = "#{path}/**/*_test.{js,js.coffee,coffee}"
  end
end
