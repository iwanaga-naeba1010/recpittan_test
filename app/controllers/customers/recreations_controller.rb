# frozen_string_literal: true

class Customers::RecreationsController < Customers::ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :require_customer

  # rubocop:disable Metrics/AbcSize
  def index
    sort_order = params[:sort_order] || :newest
    @tag_params = params[:tags] || []
    @prefectures = RecreationPrefecture.distinct.pluck(:name)
    @sorted_prefectures = Recreation.public_recs
                                    .joins(:recreation_prefectures)
                                    .distinct
                                    .pluck('recreation_prefectures.name')
                                    .sort_by { |name| RecreationPrefecture.names.index(name) || RecreationPrefecture.names.length }
    @tags = Tag.where(kind: [:tag, :target])
    recs = Recreation.public_recs
                     .by_kind(params[:kind])
                     .by_category(params[:category])
                     .by_prefecture(params[:prefecture])
                     .by_tags(@tag_params)
                     .by_price_range(params[:price_range])
                     .sorted_by(sort_order)

    recs = recs.where('title ILIKE ?', "%#{params[:title]}%") if params[:title].present?
    @recs = recs.page(params[:page]).per(params[:per_page] || 30)
  end
  # rubocop:enable Metrics/AbcSize

  def show
    @recreation = Recreation.public_recs.find(params[:id])
    @evaluations = Evaluation.public_and_not_null_message.with_recreation(@recreation)
  end
end
