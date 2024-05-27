# frozen_string_literal: true

module Resources
  module RecreationPlanEstimates
    class Create < ActiveInteraction::Base
      integer :number_of_people
      integer :start_month
      integer :transportation_expenses
      integer :recreation_plan_id
      integer :user_id

      validates :number_of_people, presence: true
      validates :start_month, presence: true
      validates :transportation_expenses, presence: true
      validates :recreation_plan_id, presence: true
      validates :user_id, presence: true

      def execute
        RecreationPlanEstimate.create!(
          number_of_people:,
          start_month:,
          transportation_expenses:,
          recreation_plan_id:,
          user_id:
        )
      end
    end
  end
end
