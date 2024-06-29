# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
# NOTE: sentryで読み込まれる前にrequire
require 'active_support/parameter_filter'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# NOTE(okubo): DEPRECATION WARNINGを出さないようにする
ActiveSupport::Deprecation.silenced = true

module MachingSystem
  class Application < Rails::Application
    config.load_defaults 6.1
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}').to_s]
    config.paths.add "#{config.root}/app/lib/*", eager_load: true
    config.active_record.encryption.primary_key = ENV.fetch('ENCRYPTION_PRIMARY_KEY', nil)
    config.active_record.encryption.deterministic_key = ENV.fetch('ENCRYPTION_DETERMINISTIC_KEY', nil)
    config.active_record.encryption.key_derivation_salt = ENV.fetch('ENCRYPTION_KEY_DERIVATION_SALT', nil)

    config.generators do |g|
      g.stylesheets false
      g.javascripts false
      g.helper false
    end

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: false,
                       request_specs: true
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

  end
end
