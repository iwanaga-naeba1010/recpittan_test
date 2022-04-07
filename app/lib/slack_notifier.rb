# frozen_string_literal: true

class SlackNotifier
  attr_reader :client, :channel

  WEBHOOK_URL = ENV['SLACK_WEBHOOK'] # 環境SLACK_WEBHOOK_URLにwebhook urlを格納
  USER_NAME = 'system bot'

  def initialize(channel:)
    # NOTE: production以外は開発用channelで管理
    channel_depends_on_env = '#開発用slack投稿確認channel'
    # NOTE: staging等では本番のslackに飛ばしたくないので、制限を設けている
    disable_slack = (ENV['DISABLE_SLACK'].to_s.downcase == 'true')

    if Rails.env.production? && !disable_slack
      channel_depends_on_env = channel
    end

    @client = Slack::Notifier.new(WEBHOOK_URL, channel: channel_depends_on_env, username: USER_NAME)
  end

  def send(title, message)
    return if Rails.env.test?

    payload = {
      fallback: 'Application raise error',
      text: message,
      color: 'bad'
    }
    client.post text: title, attachments: [payload]
  end
end
