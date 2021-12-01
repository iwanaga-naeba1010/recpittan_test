# frozen_string_literal: true

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
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop', require: false
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'rubocop-rails', require: false
  gem 'brakeman', require: false
  gem 'rails_best_practices', require: false
  gem 'haml_lint', require: false
  gem 'scss_lint', require: false
end

group :development do
  gem 'letter_opener_web'
  gem 'rails-erd'
  gem 'web-console'
  gem 'rack-mini-profiler'
  gem 'listen'
  gem 'spring'
end

group :test do
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers', require: false
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'rails-controller-testing'
  gem 'rspec-validator_spec_helper'
  gem 'rspec-request_describer'
  gem 'rspec-parameterized'
  gem 'shoulda-matchers'
end

group :production do
  gem 'fog-aws'
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
gem 'seed-fu' # staging/productionでも使いたいから

gem 'kaminari'
gem 'ransack'

# 開発環境でUserを切り替える
gem 'switch_user'

# slack通知
gem 'slack-notifier'

# API
gem 'oj'

# cache
gem 'redis'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
