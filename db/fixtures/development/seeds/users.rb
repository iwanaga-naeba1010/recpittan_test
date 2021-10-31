# frozen_string_literal: true

Rails.application.routes.default_url_options[:host] = 'localhost'
ActionMailer::Base.default_url_options[:port] = '3000'
Devise::Mailer.perform_deliveries = false

User.seed do |s|
  s.id = 1
  s.role = 2
  s.email = 'admin@gmail.com'
  s.confirmed_at = Time.now.utc
  s.password = '11111111'
end

## User.id == 2の施設情報
Company.seed do |s|
  s.id = 1
  s.user_id = 1
  s.name = '佐藤介護施設'
  s.facility_name = '佐藤介護施設'
  s.person_in_charge_name = '佐藤亜以'
  s.person_in_charge_name_kana = 'サトウアイ'
end

User.seed do |s|
  s.id = 2
  s.role = 0
  s.email = 'user1@gmail.com'
  s.confirmed_at = Time.now.utc
  s.password = '11111111'
end

## User.id == 2の施設情報
Company.seed do |s|
  s.id = 2
  s.user_id = 2
  s.name = '大久保介護施設'
  s.facility_name = '大久保介護施設'
  s.person_in_charge_name = '大久保将広'
  s.person_in_charge_name_kana = 'オオクボマサヒロ'
end

User.seed do |s|
  s.id = 3
  s.role = 0
  s.email = 'user2@gmail.com'
  s.confirmed_at = Time.now.utc
  s.password = '11111111'
end

User.seed do |s|
  s.id = 4
  s.role = 1
  s.email = 'span@gmail.com'
  s.confirmed_at = Time.now.utc
  s.password = '11111111'
end

## User.id == 4のパートナー情報
Partner.seed do |s|
  s.id = 1
  s.user_id = 4
  s.name = 'span!'
  s.title = ''
  s.description = ''
  s.image = Rails.root.join("db/fixtures/images/span.png").open
end

User.seed do |s|
  s.id = 5
  s.role = 1
  s.email = 'maeda@gmail.com'
  s.confirmed_at = Time.now.utc
  s.password = '11111111'
end

## User.id == 4のパートナー情報
Partner.seed do |s|
  s.id = 2
  s.user_id = 5
  s.name = '前田竜、田中宏典'
  s.title = ''
  s.description = ''
  s.image = Rails.root.join("db/fixtures/images/maeda.png").open
end
