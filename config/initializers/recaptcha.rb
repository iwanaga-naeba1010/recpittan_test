Recaptcha.configure do |config|
  config.enterprise = true
  config.site_key  = ENV['RECAPTCHA_ENTERPRISE_SITE_KEY']
  config.enterprise_api_key = ENV['RECAPTCHA_ENTERPRISE_API_KEY']
  config.enterprise_project_id = ENV['RECAPTCHA_ENTERPRISE_PROJECT_ID']
end
