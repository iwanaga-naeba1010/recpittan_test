# frozen_string_literal: true

class Customers::EvaluationsController < Customers::ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :require_customer

  def index
    @recreation = Recreation.find(params[:recreation_id])
    @evaluations = Evaluation.public_and_not_null_message.with_recreation(@recreation).order(id: :desc)
  end
end
