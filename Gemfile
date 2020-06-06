source 'https://rubygems.org'

# Heroku uses the ruby version to configure your application's runtime.
ruby '2.6.6'

gem 'autoprefixer-rails'
gem 'awesome_print'
gem 'bootsnap'
gem 'bootstrap-sass'
gem 'coffee-rails', '~> 4.x'
gem 'httparty'
gem 'jquery-rails'
gem 'nokogiri'
gem 'pg'
gem 'puma'
gem 'rack-canonical-host'
gem 'rails', '~> 5.2.4'
gem 'sassc-rails'
gem 'simple_form'
gem 'slim-rails'
gem 'uglifier'

group :production, :acceptance do
  gem 'rack-timeout'
  gem 'rails_stdout_logging'
end

group :test do
  gem 'fuubar'
  gem 'capybara'
  #gem 'capybara-email'
  gem 'poltergeist'
  #gem 'timecop'
  gem 'database_cleaner'
  gem 'simplecov'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'jasmine-rails'
  #gem 'cane'
  #gem 'morecane'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'foreman'
  gem 'growl'
  gem 'launchy'
  gem 'listen'
  gem 'pry-byebug'
  gem 'rb-fsevent'
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
end

gem "bundle-audit", "~> 0.1.0"
