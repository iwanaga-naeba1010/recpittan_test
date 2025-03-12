# frozen_string_literal: true

ActiveAdmin.register CompanyMemo do
  menu false # NOTE: サイドバーに表示しない設定
  actions :create
  belongs_to :company
  permit_params(
    %i[company_id body]
  )

  controller do
    def create
      company_id = params[:company_memo][:company_id].to_i
      body = params[:company_memo][:body]
      memo = CompanyMemo.new(
        company_id:,
        body:
      )
      memo.save
      company = Company.find(company_id)
      message = <<~MESSAGE
        施設名： #{company.facility_name}
        管理画面施設URL： #{admin_company_url(company_id)}
        内容: #{body}
      MESSAGE

      begin
        SlackNotifier.new(channel: '#-メモ投稿履').send(
          '管理画面から施設に関するメモを記録しました',
          message
        )
      rescue Slack::Notifier::APIError => e
        Rails.logger.error("Slack通知エラー: #{e.message}")
        Sentry.capture_exception(e)
      end

      redirect_to admin_company_path(company_id)
    end
  end
end
