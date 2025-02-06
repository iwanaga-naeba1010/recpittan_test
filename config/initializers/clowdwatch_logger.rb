# frozen_string_literal: true

if Rails.env.production?
  require_relative '../../app/lib/cloudwatch_logger'

  cloudwatch_logger = CloudwatchLogger.new(
    ENV.fetch('CLOUDWATCH_LOG_GROUP_NAME', nil),
    "#{Rails.env}-#{Time.zone.now.strftime('%Y-%m-%d')}",
    region: ENV.fetch('AWS_REGION', nil)
  )

  Rails.logger = ActiveSupport::TaggedLogging.new(Logger.new($stdout))
  Rails.logger.extend(ActiveSupport::Logger.broadcast(cloudwatch_logger))
end
