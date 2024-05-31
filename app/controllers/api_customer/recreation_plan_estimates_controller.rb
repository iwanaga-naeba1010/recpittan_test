# frozen_string_literal: true

module ApiCustomer
  class RecreationPlanEstimatesController < ApplicationController
    def create
      recreation_plan_estimate = Resources::RecreationPlanEstimates::Create.run!(
        number_of_people: params_create[:number_of_people].to_i,
        start_month: params_create[:start_month].to_i,
        transportation_expenses: params_create[:transportation_expenses].to_i,
        recreation_plan_id: params_create[:recreation_plan_id].to_i,
        user_id: current_user.id
      )

      if recreation_plan_estimate.valid?
        recreation_plan_title = RecreationPlan.find(recreation_plan_estimate.recreation_plan_id).title
        message = <<~MESSAGE
          案件ID： #{recreation_plan_estimate.id}
          管理画面案件URL： #{admin_recreation_plan_estimate_path(recreation_plan_estimate.id)}
          プランタイトル: #{recreation_plan_title}
        MESSAGE
        SlackNotifier.new(channel: '#generate_recreation_plan_estimate_notifier').send('施設が見積書を発行しました', message)
        render json: RecreationPlanEstimateSerializer.new.serialize(recreation_plan_estimate:), status: :created
      else
        render json: { errors: recreation_plan_estimate.errors.full_messages }, status: :unprocessable_entity
      end
    rescue StandardError => e
      Sentry.capture_exception(e)
      render_json([e.message], status: 422)
    end

    private def params_create
      params.require(:recreation_plan_estimate).permit(
        :number_of_people, :start_month, :transportation_expenses, :recreation_plan_id
      )
    end
  end
end
