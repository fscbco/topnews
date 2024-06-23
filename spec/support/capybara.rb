# frozen_string_literal: true

require "capybara/rspec"
require "selenium/webdriver"

Capybara.configure do |config|
  config.default_driver = :selenium_chrome
  config.javascript_driver = :selenium_chrome
  config.default_max_wait_time = 5
  config.app_host = "http://localhost:3000"
end
