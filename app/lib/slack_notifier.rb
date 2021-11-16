# frozen_string_literal: true

class SlackNotifier
  attr_reader :client, :channel

  WEBHOOK_URL = ENV['SLACK_WEBHOOK_URL'] # 環境SLACK_WEBHOOK_URLにwebhook urlを格納
  USER_NAME = "system bot"

  def initialize(channel:)
    @client = Slack::Notifier.new(WEBHOOK_URL, channel: channel, username: USER_NAME)
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
