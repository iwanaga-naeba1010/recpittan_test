# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @latest_recreations = Recreation
                          .public_recs
                          .includes(:user, :recreation_prefectures)
                          .order(created_at: :desc)
                          .limit(4)
    @popular_recreations = Recreation
                           .public_recs
                           .includes(:user, :recreation_prefectures)
                           .sorted_by(:number_of_recreations_held)
                           .limit(4)
    @recommended_visiting_recreations = Recreation
                                        .public_recs
                                        .where(kind: :visit)
                                        .includes(:user, :recreation_prefectures)
                                        .sorted_by(:number_of_recreations_held)
                                        .limit(4)
    @prefectures = Recreation.joins(:recreation_prefectures)
                             .distinct
                             .pluck('recreation_prefectures.name')

    today = Time.zone.today
    @top_banner = Rails.cache.fetch('home/top_banner', expires_in: 15.minutes) do
      TopBanner.find_by('start_date <= ? AND end_date >= ?', today, today)
    end

    @evaluations = Evaluation
                   .public_and_not_null_message
                   .includes(report: { order: :recreation })
                   .includes(report: { order: { user: :company } })
                   .latest(10)
                   .load_async
    @tags = Tag.where(kind: :tag).load_async.to_a
  end

  private

  def pick_recreation_by_id(recreations:, id:)
    recreations.select { |rec| rec.id == id }
  end
end
