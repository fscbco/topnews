# frozen_string_literal: true

require "webmock/rspec"

VCR.configure do |config|
  vcr_mode = /rec/i.match?(ENV["VCR_MODE"]) ? :all : :once
  config.cassette_library_dir = "#{::Rails.root}/spec/cassettes"
  config.hook_into(:webmock)

  config.default_cassette_options = {
    record: vcr_mode,
    match_requests_on: %i[method uri body]
  }
  config.configure_rspec_metadata!
end
