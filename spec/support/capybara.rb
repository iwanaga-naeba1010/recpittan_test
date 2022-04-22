# frozen_string_literal: true

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
    Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: browser_options)
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
