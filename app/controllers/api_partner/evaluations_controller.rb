# frozen_string_literal: true

module ApiPartner
  class EvaluationsController < ApplicationController
    before_action :set_recreation, only: %i[index]

    def index
      evaluations = Evaluation
                    .includes(report: [{ order: [:recreation, :user] }, { order: { user: :company } }])
                    .public_and_not_null_message
                    .with_recreation(@recreation)
      render_json EvaluationSerializer.new.serialize_list(evaluations:)
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      render_json([e.message], status: 401)
    end

    private def set_recreation
      @recreation = current_user.recreations.find(params[:recreation_id])
    end
  end
end
