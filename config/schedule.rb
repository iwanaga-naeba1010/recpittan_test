# frozen_string_literal: true

ENV.each { |k, v| env(k, v) }

env :GEM_PATH, ENV.fetch('BUNDLE_PATH', nil)
set :output, 'log/cron.log'
set :environment, ENV['RAILS_ENV'] || 'development'

every 1.hour do
  rake 'update_held_order:run'
end

every 1.day, at: '9:00 am' do
  rake 'send_final_check_mail:run'
end

every 1.day, at: '12:00 am' do
  rake 'sitemap:refresh'
end
