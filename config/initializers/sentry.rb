# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = 'https://a25bef58bb664200906f6622b8b1dedb@o1024150.ingest.sentry.io/6179819'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  config.traces_sample_rate = 1.0
  # config.environment = Rails.env
  # config.enabled_environments = %w[production]
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
