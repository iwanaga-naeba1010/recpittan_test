# frozen_string_literal: true

Rails.application.routes.default_url_options[:host] = 'localhost'
ActionMailer::Base.default_url_options[:port] = '3000'
Devise::Mailer.perform_deliveries = false

User.seed do |s|
  s.id = 1
  s.role = 2
  s.email = 'admin@gmail.com'
  s.confirmed_at = Time.now.utc
  s.name = 'admin'
  s.password = '11111111'
end

User.seed do |s|
  s.id = 2
  s.role = 0
  s.email = 'user1@gmail.com'
  s.confirmed_at = Time.now.utc
  s.name = 'user1'
  s.password = '11111111'
end

User.seed do |s|
  s.id = 3
  s.role = 0
  s.email = 'user2@gmail.com'
  s.confirmed_at = Time.now.utc
  s.name = 'user2'
  s.password = '11111111'
end

User.seed do |s|
  s.id = 4
  s.role = 1
  s.email = 'user3@gmail.com'
  s.confirmed_at = Time.now.utc
  s.name = 'span!'
  s.password = '11111111'
end

User.seed do |s|
  s.id = 5
  s.role = 1
  s.email = 'user4@gmail.com'
  s.confirmed_at = Time.now.utc
  s.name = 'user4'
  s.password = '11111111'
end
