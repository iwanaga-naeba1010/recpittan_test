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
      # NOTE(okubo): 吉本のみ文字で検索しているので三項演算子で対応
      @tag = value.is_a?(Integer) ? Tag.find(value.to_i) : Tag.find_by(name: value)
    end
  end

  def show
    @evaluations = Evaluation.where.not(message: '').where(is_public: :public).
                   joins(report: :order).merge(Order.where(recreation_id: set_recreation)).limit(3).order(id: :desc)
  end

  private def set_recreation
    @recreation = Recreation.public_recs.find(params[:id])
  end
end
