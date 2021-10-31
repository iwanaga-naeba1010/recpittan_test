source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'webpacker'
gem 'turbolinks'
gem 'jbuilder'
gem 'bootsnap'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'letter_opener_web'
  gem 'rails-erd'
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'seed-fu'
end


group :test do
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers', require: false
  # gem 'chromedriver-helper' unless ENV.key?('CIRCLECI')。
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'rails-controller-testing'
  gem 'rspec-validator_spec_helper'
  gem 'rspec-request_describer'
  # gem 'rspec-json_matcher', github: 'whiteleaf7/rspec-json_matcher'
  gem 'rspec-parameterized'
  gem 'shoulda-matchers'
end

gem 'devise'
gem 'dotenv-rails'
gem 'rails-i18n' # devise 日本語化
gem 'devise-i18n' # devise 日本語化
# admin + UI theme
gem 'activeadmin'
gem 'arctic_admin'

gem 'annotate'
gem 'simple_form'
gem 'enumerize'

gem 'carrierwave'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
