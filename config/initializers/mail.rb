if Rails.env.production?
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.perform_caching = false
  ActionMailer::Base.perform_deliveries = true
  ActionMailer::Base.default_url_options = { host: 'everyplus.jp' }
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: ENV['MAIL_ADDRESS'],
    domain: ENV['MAIL_DOMAIN'],
    port: ENV['MAIL_PORT'],
    user_name: ENV['MAIL_USER_NAME'],
    password: ENV['MAIL_PASSWORD'],
    authentication: 'plain',
    enable_starttls_auto: false
  }
elsif Rails.env.development?
  ActionMailer::Base.perform_caching = false
  ActionMailer::Base.default_options = { host: 'localhost', port: 3000 }
  ActionMailer::Base.delivery_method = :letter_opener_web
  ActionMailer::Base.default_url_options = { host: 'localhost', port: 3000 }
else
  ActionMailer::Base.delivery_method = :test
  ActionMailer::Base.default_options = { host: 'localhost', port: 3000 }
  ActionMailer::Base.default_url_options = { host: 'localhost', port: 3000 }
end
