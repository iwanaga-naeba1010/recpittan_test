# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  SUMMER_RECOMMENDATION_IDS = [
    262,
    106,
    64,
    37,
    73,
    116,
    258,
    103,
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
    146,
    23,
    89,
    217,
    270,
    136,
    10,
    263,
    219,
    109,
    108,
  ].freeze

  def index
    @yoshimoto = Rails.cache.fetch('home/yoshimoto_tag', expires_in: 1.week) do
      Tag.find_by(name: '吉本')
    end

    @summer_recommendation_recs = Rails.cache.fetch('home/trial_recs', expires_in: 6.hours) do
      queried_recreations = Recreation.public_recs.where(id: SUMMER_RECOMMENDATION_IDS).to_a
      SUMMER_RECOMMENDATION_IDS.map { |id| pick_recreation_by_id(recreations: queried_recreations, id: id) }.compact.flatten
    end

    @yoshimoto_recs = Rails.cache.fetch('home/yoshimoto_recs', expires_in: 6.hours) do
      queried_recreations = Recreation.public_recs.where(id: YOSHIMOTO_IDS).to_a
      YOSHIMOTO_IDS.map { |id| pick_recreation_by_id(recreations: queried_recreations, id: id) }.compact.flatten
    end

    @less_than_ten_thousand_yen_recs = Rails.cache.fetch('home/under_ten_thou_recs', expires_in: 6.hours) do
      queried_recreations = Recreation.public_recs.where(id: LESS_THAN_TEN_THOUSANT_YEN_IDS).to_a
      LESS_THAN_TEN_THOUSANT_YEN_IDS.map do |id|
        pick_recreation_by_id(recreations: queried_recreations, id: id)
      end.compact.flatten
    end

    @evaluations = Evaluation.where(is_public: :private).where.not(message: '').where.not(message: 'システムの自動投稿').latest(10)
    @tags = Tag.where(kind: :tag).to_a
  end

  private

  def pick_recreation_by_id(recreations:, id:)
    recreations.select { |rec| rec.id == id }
  end
end
# rubocop:enable Metrics/AbcSize
