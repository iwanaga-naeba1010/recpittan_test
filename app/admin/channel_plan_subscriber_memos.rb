# frozen_string_literal: true

ActiveAdmin.register ChannelPlanSubscriberMemo do
  menu false # NOTE: サイドバーに表示しない設定
  actions :create
  belongs_to :channel_plan_subscriber
  permit_params(
    %i[channel_plan_subscriber_id body]
  )

  controller do
    def create
      channel_plan_subscriber_id = params[:channel_plan_subscriber_memo][:channel_plan_subscriber_id].to_i
      memo = ChannelPlanSubscriberMemo.new(permitted_params[:channel_plan_subscriber_memo])
      memo.save
      message = <<~MESSAGE
        案件ID： #{channel_plan_subscriber_id}
        管理画面案件URL： #{admin_channel_plan_subscriber_url(channel_plan_subscriber_id)}
        内容: #{body}
      MESSAGE
      SlackNotifier.new(channel: '#-メモ投稿履').send('管理画面からチャンネル登録施設に関するメモを記録しました', message)
      redirect_to admin_channel_plan_subscriber_path(channel_plan_subscriber_id)
    end
  end
end
