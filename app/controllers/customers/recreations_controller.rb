# frozen_string_literal: true

class Customers::RecreationsController < Customers::ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :require_customer

  def index
    sort_order = params[:sort_order] || :newest
    tags = params[:tags] || []
    @distinct_prefectures = RecreationPrefecture.distinct.pluck(:name)
    @sorted_prefectures = RecreationPrefecture.names & @distinct_prefectures
    @tags = Tag.where(kind: [:tag, :target])
    recs = Recreation.public_recs.includes(:recreation_images,
                                           :recreation_prefectures,
                                           :tags,
                                           :profile)
                     .by_kind(params[:kind])
                     .by_category(params[:category])
                     .by_prefecture(params[:prefecture])
                     .by_tags(tags)
                     .by_price_range(params[:price_range])
                     .sorted_by(sort_order)
    @recs_size = recs.size
    @recs = recs.page(params[:page]).per(params[:per_page] || 30)
  end

  def show
    @recreation = Recreation.public_recs.includes(:orders).find(params[:id])
    @evaluations = Evaluation.public_and_not_null_message.with_recreation(@recreation)
  end
end
