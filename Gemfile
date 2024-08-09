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
gem 'rspec-rails'
gem 'sass-rails'
gem 'selenium-webdriver', group: [:development, :test]
gem 'spring', group: :development
gem 'turbolinks'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'uglifier'
gem 'web-console', group: :development

gem 'bootsnap', require: false
gem 'bootstrap', '~> 4.4.1'
gem 'sassc-rails'
gem 'excon'
gem 'factory_bot_rails'
gem 'shoulda-matchers'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :test do
  gem 'database_cleaner-active_record'
end
