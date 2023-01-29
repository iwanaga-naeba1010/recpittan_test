# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  VISIT_REC_IDS = [
    145,
    266,
    110,
    111,
    93,
    38,
    103,
    43,
    199,
    139,
    132,
    25
  ].freeze

  ONLINE_REC_IDS = [
    109,
    108,
    20,
    18,
    89,
    146,
    70,
    15,
    12,
    79,
    29,
    142
  ].freeze

  YOSHIMOTO_IDS = [
    26,
    29,
    31,
    33,
    34,
    36,
    102
  ]

  def index
    today = Time.zone.now.to_date
    @top_banner = TopBanner.find_by('start_date <= ? AND end_date >= ?', today, today)
    @yoshimoto = Rails.cache.fetch('home/yoshimoto_tag', expires_in: 1.week) do
      Tag.find_by(name: '吉本')
    end

    @visit_recreations = Rails.cache.fetch('home/visit_recs', expires_in: 6.hours) do
      queried_recreations = Recreation.public_recs.where(id: VISIT_REC_IDS).load_async.to_a
      VISIT_REC_IDS.map do |id|
        pick_recreation_by_id(recreations: queried_recreations, id: id)
      end.compact.flatten
    end

    @online_recreations = Rails.cache.fetch('home/online_recs', expires_in: 6.hours) do
      queried_recreations = Recreation.public_recs.where(id: ONLINE_REC_IDS).load_async.to_a
      ONLINE_REC_IDS.map { |id| pick_recreation_by_id(recreations: queried_recreations, id: id) }.compact.flatten
    end

    @yoshimoto_recs = Rails.cache.fetch('home/yoshimoto_recs', expires_in: 6.hours) do
      queried_recreations = Recreation.public_recs.where(id: YOSHIMOTO_IDS).load_async.to_a
      YOSHIMOTO_IDS.map { |id| pick_recreation_by_id(recreations: queried_recreations, id: id) }.compact.flatten
    end

    @evaluations = Evaluation.public_and_not_null_message.latest(10).load_async
    @tags = Tag.where(kind: :tag).load_async.to_a
  end

  private

  def pick_recreation_by_id(recreations:, id:)
    recreations.select { |rec| rec.id == id }
  end
end
# rubocop:enable Metrics/AbcSize
