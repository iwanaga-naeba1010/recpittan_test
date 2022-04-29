# frozen_string_literal: true

if ENV['LOCAL'].present? && ENV['LOCAL'] == 'true'
  Capybara.register_driver :remote_chrome do |app|
    url = ENV['SELENIUM_DRIVER_URL']
    caps = ::Selenium::WebDriver::Remote::Capabilities.chrome(
      'goog:chromeOptions' => {
        'args' => [
          'no-sandbox',
          'headless',
          'disable-gpu',
          'window-size=1680,1050',
        ]
      }
    )
    Capybara::Selenium::Driver.new(app, browser: :remote, url: url, capabilities: caps)
  end

  RSpec.configure do |config|
    config.before(:each) do |example|
      if %i[system feature].include?(example.metadata[:type])
        if example.metadata[:js]
          Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
          # Capybara.app_host = "http://web:3000"
          # Capybara.server_host = "web"
          Capybara.server_port = '3000'
          # Capybara.app_host = "http://#{Capybara.server_host}"
          # TODO(okubo): IP固定したいが、chrome driverもしないといけないぽい
          puts '=================='
          puts Capybara.server_port
          puts Capybara.server_host
          puts Capybara.app_host
          puts '=================='
          # Capybara.app_host = "http://#{Capybara.server_host}"
          Capybara.app_host = "http://#{Capybara.server_host}"
          driven_by :remote_chrome
          # driven_by :selenium_chrome_headless
        else
          driven_by :rack_test
        end
      end
    end
  end
else
  RSpec.configure do |config|
    Capybara.register_driver :selenium_chrome_headless do |app|
      Capybara::Selenium::Driver.load_selenium
      browser_options = ::Selenium::WebDriver::Chrome::Options.new
      browser_options.args << '--window-size=1400,2000'
      browser_options.args << '--headless'
      browser_options.args << '--lang=ja-JP'
      browser_options.args << '--no-sandbox'
      browser_options.args << '--disable-dev-shm-usage'
      browser_options.args << '--disable-gpu' if Gem.win_platform?
      Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
    end

    config.before(:each) do |example|
      if %i[system feature].include?(example.metadata[:type])
        if example.metadata[:js]
          driven_by :selenium_chrome_headless
        else
          driven_by :rack_test
        end
      end
    end
  end
end
