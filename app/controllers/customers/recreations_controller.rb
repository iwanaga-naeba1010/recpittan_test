# frozen_string_literal: true

class Customers::RecreationsController < Customers::ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :require_customer

  def index
    @q = Recreation.ransack(params[:q])
    @categories = Tag.categories
    @recs = @q.result.page(params[:page]).per(1)
    @breadcrumbs = [
      { name: 'トップ' },
      { name: '一覧' }
    ]
  end

  def show
    @breadcrumbs = [
      { name: 'トップ' },
      { name: '一覧' },
      { name: '旅行' },
      { name: '～おはらい町おかげ横丁ツアー～' }
    ]
    @recreation = Recreation.find(params[:id])
  end
end
