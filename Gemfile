source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

gem 'coffee-rails'
gem 'devise'
gem 'haml'
gem 'jbuilder'
gem 'kaminari'
gem 'pg'
gem 'pg_search'
gem 'pry-rails'
gem 'puma'
gem 'rails', '~> 7.0.3'
gem 'rspec-rails'
gem 'sass-rails'
gem 'tailwindcss-rails', '~> 2.0' # Add Tailwind - a CSS framework
gem 'turbolinks'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'uglifier'

group :development do
  gem 'listen'
  gem 'spring'
  gem 'web-console'
end

group :test do
  gem 'shoulda-matchers', '~> 5.0' # One-liner matchers for RSpec
  gem 'webmock' # Mock external API calls for testing
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara'
  gem 'factory_bot' # Create factories (objects) for testing
  gem 'factory_bot_rails' # Configures FactoryBot for Rails
  gem 'selenium-webdriver'
end

