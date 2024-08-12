
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.configure_rspec_metadata! # enables :vcr tag
  config.hook_into :webmock
end
