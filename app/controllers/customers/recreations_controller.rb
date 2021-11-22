# frozen_string_literal: true

class Customers::RecreationsController < Customers::ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :require_customer

  def index
    @q = Recreation.ransack(params[:q])
    @categories = Tag.categories
    @recs = @q.result.page(params[:page]).per(10)
  end

  def show
    @recreation = Recreation.find(params[:id])
  end
end
