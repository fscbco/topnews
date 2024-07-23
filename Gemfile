source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

gem 'rails', '~> 7.0.3'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'turbolinks'
gem 'jbuilder'
gem 'devise'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rspec-rails'
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'webmock'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'web-console'
  gem 'pry-rails'
end

group :test do
  gem 'simplecov', require: false  # Optional, for test coverage
  gem 'shoulda-matchers'  # Optional, for simplified model specs
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]