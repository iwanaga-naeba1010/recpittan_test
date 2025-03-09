# frozen_string_literal: true

require 'rails_helper'
require 'aws-sdk-cloudwatchlogs'

require_relative '../../app/lib/cloudwatch_logger'

RSpec.describe CloudwatchLogger do
  let(:log_group_name) { 'test-log-group' }
  let(:log_stream_name) { 'test-log-stream' }
  let(:region) { 'ap-northeast-1' }
  let(:client) { instance_double(Aws::CloudWatchLogs::Client) }
  let(:logger) { described_class.new(log_group_name, log_stream_name, region: region) }

  before do
    allow(Aws::CloudWatchLogs::Client).to receive(:new).and_return(client)
    allow(client).to receive(:describe_log_groups).and_return(double(log_groups: []))
    allow(client).to receive(:describe_log_streams).and_return(double(log_streams: []))
    allow(client).to receive(:create_log_group)
    allow(client).to receive(:create_log_stream)
    logger
  end

  describe '#initialize' do
    it 'creates log group and stream if not exists' do
      expect(client).to have_received(:create_log_group).with(log_group_name: log_group_name)
      expect(client).to have_received(:create_log_stream).with(log_group_name: log_group_name, log_stream_name: log_stream_name)
    end
  end

  describe '#log' do
    let(:message) { 'Test message' }
    let(:timestamp) { (Time.now.to_f * 1000).to_i }

    before do
      allow(Time).to receive(:now).and_return(Time.zone.at(timestamp / 1000.0))
      allow(client).to receive(:put_log_events)
    end

    it 'sends log event to CloudWatch' do
      logger.log(message)
      expect(client).to have_received(:put_log_events).with(
        log_group_name: log_group_name,
        log_stream_name: log_stream_name,
        log_events: [{ timestamp: timestamp, message: "INFO: #{message}" }]
      )
    end
  end

  describe 'error handling' do
    before do
      allow(client).to receive(:put_log_events).and_raise(Aws::CloudWatchLogs::Errors::ResourceNotFoundException.new(nil, 'Not found'))
      allow(Rails.logger).to receive(:debug) { |&block| block&.call }
    end

    it 'logs error to Rails logger' do
      logger.log('Test message')
      expect(Rails.logger).to have_received(:debug) do |&block|
        expect(block.call).to match(/Error logging to CloudWatch: Not found/)
      end
    end
  end
end
