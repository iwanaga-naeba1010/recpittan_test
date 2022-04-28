# frozen_string_literal: true

Capybara.register_driver :remote_chrome do |app|
  url = ENV['SELENIUM_DRIVER_URL']
  caps = ::Selenium::WebDriver::Remote::Capabilities.chrome(
    'goog:chromeOptions' => {
      'args' => [
        'no-sandbox',
        'headless',
        'disable-gpu',
        'window-size=1680,1050'
      ]
    }
  )
  Capybara::Selenium::Driver.new(app, browser: :remote, url: url, desired_capabilities: caps)
end

# Capybara.register_driver :selenium_chrome_headless do |app|
#   capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#     chromeOptions: {
#       args: %w[headless lang=ja-JP no-sandbox disable-dev-shm-usage disable-gpu]
#     }
#   )
#
#   Capybara::Selenium::Driver.new(
#     app,
#     browser: :chrome,
#     desired_capabilities: capabilities
#   )
# end

# Capybara.javascript_driver = :selenium_chrome_headless

RSpec.configure do |config|
  config.before(:each) do |example|
    if %i[system feature].include?(example.metadata[:type])
      if example.metadata[:js]
        Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
        Capybara.app_host = "http://#{Capybara.server_host}"
        driven_by :remote_chrome
        # driven_by :selenium_chrome_headless
      else
        driven_by :rack_test
      end
    end
  end
end
