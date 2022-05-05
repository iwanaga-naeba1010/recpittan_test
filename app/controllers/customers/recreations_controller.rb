# frozen_string_literal: true

class Customers::RecreationsController < Customers::ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :require_customer
  before_action :set_recreation, only: %i[show]

  def index
    @q = Recreation.public_recs.ransack(params[:q])
    @categories = Tag.categories
    @recs = @q.result(distinct: true).page(params[:page]).per(30)
    value = @q.base.conditions&.first&.values&.first&.value
    is_tag_class = @q.base.conditions&.first&.attributes&.first&.klass == Tag
    if value && is_tag_class
      @tag = Tag.find(value.to_i)
    end
  end

  def show; end

  private def set_recreation
    @recreation = Recreation.public_recs.find(params[:id])
  end
end
