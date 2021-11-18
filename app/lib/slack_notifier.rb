# frozen_string_literal: true

class SlackNotifier
  attr_reader :client, :channel

  WEBHOOK_URL = ENV['SLACK_WEBHOOK'] # 環境SLACK_WEBHOOK_URLにwebhook urlを格納
  USER_NAME = "system bot"

  def initialize(channel:)
    # NOTE: production以外は開発用channelで管理
    channel_depends_on_env = Rails.env.productoin? ? channel: '#開発用slack投稿確認channel'
    @client = Slack::Notifier.new(WEBHOOK_URL, channel: channel_depends_on_env, username: USER_NAME)
  end

  def send(title, message)
    payload = {
      fallback: "Application raise error",
      text: message,
      color: "bad"
    }
    client.post text: title, attachments: [payload]
  end
end
