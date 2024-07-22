# frozen_string_literal: true

module ApiPartner
  class EvaluationRepliesController < ApplicationController
    def index
      evaluations = EvaluationReply
                    .includes(evaluation: { report: { order: [:recreation, :user, { user: :company }] } })
      render_json EvaluationSerializer.new.serialize_list(evaluations:)
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      render_json([e.message], status: 401)
    end

    def create
      evaluation_reply = Resources::EvaluationReplies::Create.run!(
        evaluation_id: params_create[:evaluation_id],
        message: params_create[:message]
      )
      render_json EvaluationReplySerializer.new.serialize(evaluation_reply:)
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      render_json([e.message], status: 422)
    end

    private def params_create
      params.require(:evaluation_reply).permit(
        %i[message evaluation_id]
      )
    end
  end
end
