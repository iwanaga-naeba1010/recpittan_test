# frozen_string_literal: true

module Api
  class SlackNotifiersController < ApplicationController
    def create
      recreation = Recreation.find(params[:recreation_id].to_i)
      message = <<~MESSAGE
        会社名: #{current_user.company.name + current_user.company.facility_name}
        管理画面URL: #{admin_company_url(current_user.company.id)}
        担当者名: #{current_user.company.person_in_charge_name}
        電話番号: #{current_user.company.tel}

        レク名: #{recreation.title}
        パートナー名: #{recreation.profile_name}
      MESSAGE

      SlackNotifier.new(channel: '#料金お問い合わせ').send('新規お問い合わせ', message)
      render_json({ status: 'success' })
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      render_json({ message: e.message }, status: 422)
    end
  end
end
