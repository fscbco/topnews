source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

gem 'byebug', platforms: [:mri, :mingw, :x64_mingw], group: [:development, :test]
gem 'capybara', group: [:development, :test]
gem 'coffee-rails'
gem 'devise'
gem 'jbuilder'
gem 'listen', group: :development
gem 'pg'
gem 'puma'
gem 'rails', '~> 7.0.3'
gem 'rest-client', '~> 2.1' # http rest client
gem 'sass-rails'
gem 'selenium-webdriver', group: [:development, :test]
gem 'spring', group: :development
gem 'turbolinks'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'uglifier'
gem 'web-console', group: :development
gem 'will_paginate', '~> 4.0', '>= 4.0.1'

group :development, :test do
  gem 'factory_bot_rails', '~> 6.4'
  gem 'faker', '~> 3.4', '>= 3.4.2' # Faker, a port of Data::Faker from Perl, is used to easily generate fake data: names, addresses, phone numbers, etc.
  gem 'pry-rails'
  gem 'rspec-rails' # RSpec for Rails
end

group :test do
  gem 'vcr', '~> 6.2' # Record your test suite's HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests.
  gem 'webmock'#, '~> 3.7', '>= 3.7.6'
end
