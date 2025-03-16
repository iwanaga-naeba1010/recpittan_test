# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.6'

gem 'rails'
gem 'pg'
gem 'puma'
gem 'sass-rails'
gem 'webpacker'
gem 'turbolinks'
gem 'jbuilder'
gem 'bootsnap'
gem 'google-api-client'
gem 'slim-rails'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop', require: false
  gem 'pry-rails'
  gem 'pry-remote'
  gem 'rubocop-rails', require: false
  gem 'slim_lint', require: false
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
  gem 'bullet'
end

group :test do
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
#  gem 'webdrivers', require: false # replaced selenium-webdriver
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'rails-controller-testing'
  gem 'rspec-validator_spec_helper'
  gem 'rspec-request_describer'
  gem 'rspec-parameterized'
  gem 'shoulda-matchers'
  gem 'utf8-cleaner'
end

group :production do
  gem 'aws-sdk-s3', require: false
end

gem 'devise'
gem 'dotenv-rails'
gem 'rails-i18n' # devise 日本語化
gem 'devise-i18n' # devise 日本語化
# admin + UI theme
gem 'activeadmin'
gem 'arctic_admin'
gem 'activeadmin_addons'

gem 'annotate'
gem 'simple_form'
gem 'enumerize'

gem 'fog-aws'
gem 'carrierwave'

gem 'kaminari'

gem 'active_hash'
gem 'rinku'

# 開発環境でUserを切り替える
gem 'switch_user'

# slack通知
gem 'slack-notifier'

# API
gem 'oj'

gem 'cocoon'
# seo
gem 'meta-tags'
gem 'sitemap_generator'

gem 'active_interaction'

gem 'sentry-ruby'
gem 'sentry-rails'

gem 'recaptcha'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# pdf
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

# logs
gem 'aws-sdk-cloudwatchlogs'

gem 'draper'

gem 'whenever', require: false
gem 'delayed_job_active_record'
gem 'activeadmin_reorderable', '~> 0.3.4'
