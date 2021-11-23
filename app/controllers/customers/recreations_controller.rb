# frozen_string_literal: true

class Customers::RecreationsController < Customers::ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :require_customer

  def index
    @q = Recreation.ransack(params[:q])
    @categories = Tag.categories
    @recs = @q.result.page(params[:page]).per(10)
    value =  @q.base.conditions&.first&.values&.first&.value
    is_tag_class = @q.base.conditions&.first&.attributes&.first&.klass == Tag
    if value && is_tag_class
      @tag = Tag.find(value.to_i)
    end
  end

  def show
    @recreation = Recreation.find(params[:id])
  end
end
