source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

gem 'byebug', platforms: [:mri, :mingw, :x64_mingw], group: [:development, :test]
gem 'capybara', group: [:development, :test]
gem 'coffee-rails'
gem 'devise'
gem 'jbuilder'
gem 'listen', group: :development
gem 'pg'
gem 'pry-rails'
gem 'puma'
gem 'rails', '~> 7.0.3'
gem 'sass-rails'
gem 'selenium-webdriver', group: [:development, :test]
gem 'spring', group: :development
gem 'turbolinks'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'uglifier'
gem 'web-console', group: :development
gem 'httparty'
gem 'pry-byebug'

group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', '~> 4.0'
end

group :test, :development do
  gem 'database_cleaner-active_record'
end
