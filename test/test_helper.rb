ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "vcr"

HACKER_NEWS_ITEM_ID = 39382092
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

VCR.configure do |config|
  config.cassette_library_dir = "test/vcr_cassettes"
  config.hook_into :webmock
  
  # https://blog.pablobm.com/2021/10/14/vcr-webdriver-errors/
  # Avoid conflict with Selenium
  config.ignore_localhost = true
  driver_hosts = Webdrivers::Common.subclasses.map { |driver| URI(driver.base_url).host }
  driver_hosts += ["github-releases.githubusercontent.com", "googlechromelabs.github.io", "storage.googleapis.com"]
  config.ignore_hosts(*driver_hosts)
end

