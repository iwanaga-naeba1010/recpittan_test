# frozen_string_literal: true

class Customers::RecreationsController < Customers::ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :require_customer

  # rubocop:disable Metrics/AbcSize
  def index
    @q = Recreation.includes(:recreation_images, :recreation_prefectures).public_recs.ransack(params[:q])
    @categories = Tag.categories
    @recs = @q.result(distinct: true).page(params[:page]).per(30)
    @distinct_prefectures = RecreationPrefecture.select(:name).distinct.map(&:name)
    @sorted_prefectures = RecreationPrefecture.names & @distinct_prefectures
    value = @q.base.conditions&.first&.values&.first&.value
    is_tag_class = @q.base.conditions&.first&.attributes&.first&.klass == Tag
    if value && is_tag_class
      # NOTE(okubo): 吉本のみ文字で検索しているので三項演算子で対応
      @tag = value.is_a?(Integer) ? Tag.find(value.to_i) : Tag.find_by(name: value)
    end
  end
  # rubocop:enable Metrics/AbcSize

  def show
    @recreation = Recreation.public_recs.includes(:orders).find(params[:id])
    @evaluations = Evaluation.public_and_not_null_message.with_recreation(@recreation)
  end
end
