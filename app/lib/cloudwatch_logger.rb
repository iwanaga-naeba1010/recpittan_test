# frozen_string_literal: true

require 'aws-sdk-cloudwatchlogs'

class CloudwatchLogger
  def initialize(log_group_name, log_stream_name, region: 'ap-northeast-1')
    @client = Aws::CloudWatchLogs::Client.new(region: region)
    @log_group_name = log_group_name
    @log_stream_name = log_stream_name

    # ロググループとログストリームが存在しない場合は作成
    create_log_group_and_stream
  end

  def log(message, level: 'INFO')
    timestamp = (Time.now.to_f * 1000).to_i # ミリ秒単位のタイムスタンプ
    @client.put_log_events(
      log_group_name: @log_group_name,
      log_stream_name: @log_stream_name,
      log_events: [
        {
          timestamp: timestamp,
          message: "#{level}: #{message}"
        }
      ]
    )
  rescue Aws::CloudWatchLogs::Errors::ResourceNotFoundException => e
    Rails.logger.debug { "Error logging to CloudWatch: #{e.message}" }
  end

  private

  def create_log_group_and_stream
    # ロググループが存在しない場合は作成
    unless @client.describe_log_groups(log_group_name_prefix: @log_group_name).log_groups.any?
      @client.create_log_group(log_group_name: @log_group_name)
    end

    # ログストリームが存在しない場合は作成
    unless @client.describe_log_streams(log_group_name: @log_group_name, log_stream_name_prefix: @log_stream_name).log_streams.any?
      @client.create_log_stream(log_group_name: @log_group_name, log_stream_name: @log_stream_name)
    end
  end
end
