# frozen_string_literal: true

class Customers::RecreationEvaluationsController < Customers::ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :require_customer

  def index
    @recreation = Recreation.includes(:tags).find(params[:recreation_id])
    @evaluations = Evaluation
                   .public_and_not_null_message
                   .with_recreation(@recreation)
                   .includes(report: { order: { user: :company } })
                   .order(id: :desc)
  end
end
