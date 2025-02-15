# frozen_string_literal: true

ActiveAdmin.register OrderMemo do
  menu false # NOTE: サイドバーに表示しない設定
  actions :create
  belongs_to :order
  permit_params(
    %i[order_id body]
  )

  controller do
    def create
      order_id = params[:order_memo][:order_id].to_i
      body = params[:order_memo][:body]
      memo = OrderMemo.new(
        order_id:,
        body:
      )
      memo.save
      message = <<~MESSAGE
        案件ID： #{order_id}
        管理画面案件URL： #{admin_order_url(order_id)}
        内容: #{body}
      MESSAGE

      begin
        SlackNotifier.new(channel: '#-メモ投稿履').send(
          '管理画面から案件に関するメモを記録しました',
          message
        )
      rescue Slack::Notifier::APIError => e
        Rails.logger.error("Slack通知エラー: #{e.message}")
        Sentry.capture_exception(e)
      end

      redirect_to admin_order_path(order_id)
    end
  end
end
