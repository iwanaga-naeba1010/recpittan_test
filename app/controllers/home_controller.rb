# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  RECOMMENDATION_IDS = [
    64,
    293,
    332,
    292,
    20,
    225,
    9,
    266,
    118,
    208,
    191,
    128,
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

  LESS_THAN_TEN_THOUSANT_YEN_IDS = [
    223,
    12,
    89,
    333,
    270,
    246,
    10,
    227,
    219,
    109,
    230,
    204
  ].freeze

  def index
    raise StandardError
    @yoshimoto = Rails.cache.fetch('home/yoshimoto_tag', expires_in: 1.week) do
      Tag.find_by(name: '吉本')
    end

    @recommendation_recs = Rails.cache.fetch('home/trial_recs', expires_in: 6.hours) do
      queried_recreations = Recreation.public_recs.where(id: RECOMMENDATION_IDS).load_async.to_a
      RECOMMENDATION_IDS.map { |id| pick_recreation_by_id(recreations: queried_recreations, id: id) }.compact.flatten
    end

    @yoshimoto_recs = Rails.cache.fetch('home/yoshimoto_recs', expires_in: 6.hours) do
      queried_recreations = Recreation.public_recs.where(id: YOSHIMOTO_IDS).load_async.to_a
      YOSHIMOTO_IDS.map { |id| pick_recreation_by_id(recreations: queried_recreations, id: id) }.compact.flatten
    end

    @less_than_ten_thousand_yen_recs = Rails.cache.fetch('home/under_ten_thou_recs', expires_in: 6.hours) do
      queried_recreations = Recreation.public_recs.where(id: LESS_THAN_TEN_THOUSANT_YEN_IDS).load_async.to_a
      LESS_THAN_TEN_THOUSANT_YEN_IDS.map do |id|
        pick_recreation_by_id(recreations: queried_recreations, id: id)
      end.compact.flatten
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
