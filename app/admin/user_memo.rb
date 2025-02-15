# frozen_string_literal: true

ActiveAdmin.register UserMemo do
  menu false # NOTE: サイドバーに表示しない設定
  actions :create
  belongs_to :user
  permit_params(
    %i[user_id body]
  )

  controller do
    def create
      user_id = params[:user_memo][:user_id].to_i
      body = params[:user_memo][:body]
      memo = UserMemo.new(
        user_id:,
        body:
      )
      memo.save
      user = User.find(user_id)
      message = <<~MESSAGE
        ユーザー名： #{user.username}
        管理画面ユーザーURL： #{admin_user_url(user_id)}
        内容: #{body}
      MESSAGE

      begin
        SlackNotifier.new(channel: '#-メモ投稿履').send(
          '管理画面からユーザーに関するメモを記録しました',
          message
        )
      rescue Slack::Notifier::APIError => e
        Rails.logger.error("Slack通知エラー: #{e.message}")
        Sentry.capture_exception(e)
      end

      redirect_to admin_user_path(user_id)
    end
  end
end
