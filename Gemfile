source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'letter_opener_web'
  gem 'rails-erd'
  gem 'pry-rails'
  gem 'pry-remote'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
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
gem 'seed-fu'


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
