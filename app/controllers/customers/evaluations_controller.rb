# frozen_string_literal: true

class Customers::EvaluationsController < Customers::ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :require_customer

  def index
    @evaluations = Evaluation
                   .public_and_not_null_message
                   .includes(report: { order: { user: :company } })
                   .order(id: :desc)
                   .page(params[:page]).per(12)
  end
end
