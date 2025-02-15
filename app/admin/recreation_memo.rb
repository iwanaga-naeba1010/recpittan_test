# frozen_string_literal: true

ActiveAdmin.register RecreationMemo do
  menu false # NOTE: サイドバーに表示しない設定
  actions :create
  belongs_to :recreation
  permit_params(
    %i[recreation_id body]
  )

  controller do
    def create
      recreation_id = params[:recreation_memo][:recreation_id].to_i
      body = params[:recreation_memo][:body]
      memo = RecreationMemo.new(
        recreation_id:,
        body:
      )
      memo.save
      recreation = Recreation.find(recreation_id)
      message = <<~MESSAGE
        レクリエーション名： #{recreation.title}
        管理画面レクリエーションURL： #{admin_recreation_url(recreation_id)}
        内容: #{body}
      MESSAGE

      begin
        SlackNotifier.new(channel: '#-メモ投稿履').send(
          '管理画面からレクリエーションに関するメモを記録しました',
          message
        )
      rescue Slack::Notifier::APIError => e
        Rails.logger.error("Slack通知エラー: #{e.message}")
        Sentry.capture_exception(e)
      end

      redirect_to admin_recreation_path(recreation_id)
    end
  end
end
