source 'https://rubygems.org'

ruby File.read('.ruby-version').chomp

gem 'coffee-rails'
gem 'devise'
gem 'jbuilder'
gem 'listen', group: :development
gem 'pg'
gem 'puma'
gem 'rails', '~> 7.0.3'
gem 'sass-rails'
gem 'spring', group: :development
gem 'turbolinks'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'uglifier'
gem 'web-console', group: :development
gem 'mini_portile2', '~> 2.8'
gem 'faraday', '~> 2.7', '>= 2.7.2'
gem 'jquery-rails', '~> 4.5', '>= 4.5.1'
gem 'sidekiq', '~> 7.0', '>= 7.0.2'
gem 'redis', '~> 5.0', '>= 5.0.5'
# To manage our startup processes
gem 'foreman', '~> 0.87.2'
# For Feed bulk updates
# gem 'activerecord-import', '~> 1.4', '>= 1.4.1'
# For limiting our scope to items per page
gem 'kaminari', '~> 1.2', '>= 1.2.2'

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :test do
  gem 'capybara'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.3'
end
