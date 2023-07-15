# frozen_string_literal: true

module Resources
  module EvaluationReplies
    class Create < ActiveInteraction::Base

      integer :evaluation_id
      string :message

      validates :evaluation_id, presence: true
      validates :message, presence: true

      def execute
        EvaluationReply.create!(message:, evaluation_id:)
      end
    end
  end
end
