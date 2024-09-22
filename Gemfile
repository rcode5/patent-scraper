source 'https://rubygems.org'

# Heroku uses the ruby version to configure your application's runtime.
ruby '2.7.8'

gem 'autoprefixer-rails'
gem 'awesome_print'
gem 'bootstrap-sass'
gem 'coffee-rails', '~> 4.x'
gem 'ffi', '1.17.0'
gem 'httparty'
gem 'nokogiri', '1.11.7'
gem 'jquery-rails'
gem 'pg'
gem 'puma'
gem 'rack-canonical-host'
gem 'rails', '~> 5.2.4'
gem 'sassc-rails'
gem 'simple_form'
gem 'slim-rails'
gem 'uglifier'

gem 'mimemagic', git: 'https://github.com/mimemagicrb/mimemagic', ref: '01f92d86d15d85cfd0f20dabd025dcbd36a8a60f'

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
end
