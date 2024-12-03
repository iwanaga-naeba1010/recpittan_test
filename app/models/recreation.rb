# frozen_string_literal: true

# == Schema Information
#
# Table name: recreations
#
#  id                      :bigint           not null, primary key
#  additional_facility_fee :integer          default(2000)
#  amount                  :integer
#  base_code               :string
#  borrow_item             :text
#  bring_your_own_item     :text
#  capacity                :integer
#  category                :integer          default("event"), not null
#  description             :text
#  extra_information       :text
#  flow_of_day             :text
#  flyer_color             :string
#  is_public_price         :boolean          default(TRUE)
#  kind                    :integer          default("visit"), not null
#  material_amount         :integer
#  material_price          :integer
#  memo                    :string
#  minutes                 :integer
#  number_of_past_events   :integer          default(0), not null
#  price                   :integer
#  second_title            :string
#  status                  :integer          default("unapplied"), not null
#  title                   :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :bigint           not null
#  youtube_id              :string
#
# Foreign Keys
#
#  recreations_user_id_fkey  (user_id => users.id)
#
class Recreation < ApplicationRecord
  include Ransackable
  extend Enumerize
  # mount_uploader :instructor_image, ImageUploader

  enumerize :kind, in: { visit: 0, online: 1, mailing: 2 }, default: 0
  enumerize :status, in: { unapplied: 0, in_progress: 1, published: 2 }, default: 0
  enumerize :category, in: { event: 0, work: 1, music: 2, health: 3, travel: 4, hobby: 5, food: 6, other: 7 }, default: 0

  belongs_to :user, class_name: 'User'
  has_many :recreation_tags, dependent: :destroy, class_name: 'RecreationTag'
  has_many :tags, through: :recreation_tags, class_name: 'Tag'
  has_many :recreation_images, dependent: :destroy, class_name: 'RecreationImage'
  has_many :orders, dependent: :destroy, class_name: 'Order'
  has_many :reports, through: :orders, class_name: 'Report'
  has_many :evaluations, through: :reports, class_name: 'Evaluation'
  has_one :recreation_profile, dependent: :destroy, class_name: 'RecreationProfile'
  has_one :profile, through: :recreation_profile, class_name: 'Profile'
  has_many :recreation_prefectures, dependent: :destroy, class_name: 'RecreationPrefecture'
  has_many :recreation_memos, dependent: :destroy, class_name: 'RecreationMemo'
  has_many :favorite_recreations, dependent: :destroy, class_name: 'FavoriteRecreation'
  has_many :favorited_by_users, through: :favorite_recreations, source: :user, class_name: 'User'
  has_many :recreation_recreation_plans, dependent: :destroy, class_name: 'RecreationRecreationPlan'
  has_many :recreation_plans, through: :recreation_recreation_plans, class_name: 'RecreationPlan'
  has_many :user_recreation_recreation_plans, dependent: :destroy, class_name: 'UserRecreationRecreationPlan'
  has_many :user_recreation_plans, through: :user_recreation_recreation_plans, class_name: 'UserRecreationPlan'

  accepts_nested_attributes_for :recreation_images, allow_destroy: true
  accepts_nested_attributes_for :recreation_profile, allow_destroy: true
  accepts_nested_attributes_for :recreation_prefectures, allow_destroy: true

  delegate :name, :title, :description, :image, to: :partner, prefix: true, allow_nil: true
  delegate :name, :title, :description, :image, to: :profile, prefix: true, allow_nil: true
  delegate :username, to: :user, prefix: true
  delegate :email, to: :user, prefix: true

  # NOTE(okubo): publicは予約後なので下記で定義
  scope :public_recs, -> { where(status: :published) }
  scope :sorted_by, ->(sort_order) {
    case sort_order.to_sym
    when :price_low_to_high
      order(price: :asc)
    when :price_high_to_low
      order(price: :desc)
    when :reviews_count
      evaluations_count_subquery = Recreation.left_joins(:evaluations)
                                             .select('recreations.id, COUNT(evaluations.id) as evaluations_count')
                                             .group('recreations.id')
      joins("LEFT JOIN (#{evaluations_count_subquery.to_sql}) as evaluations_count_subquery
            ON evaluations_count_subquery.id = recreations.id")
        .order('evaluations_count_subquery.evaluations_count DESC')
    when :number_of_recreations_held
      recreations_held_subquery = Order.where(status: %i[unreported_completed final_report_admits_not finished invoice_issued paid])
                                       .select('recreation_id, COUNT(*) as held_count')
                                       .group(:recreation_id)
                                       .to_sql
      joins("LEFT JOIN (#{recreations_held_subquery}) as recreations_held ON recreations_held.recreation_id = recreations.id")
        .order(Arel.sql('COALESCE(recreations_held.held_count, 0) + recreations.number_of_past_events DESC'))
    else
      order(created_at: :desc)
    end
  }

  scope :by_kind, ->(kind) { where(kind:) if kind.present? }
  scope :by_category, ->(category) { where(category:) if category.present? }
  scope :by_prefecture, ->(prefecture) {
    joins(:recreation_prefectures).where(recreation_prefectures: { name: prefecture }) if prefecture.present?
  }
  scope :by_price_range, ->(price_ranges) {
    where(price: parse_price_ranges(price_ranges)) if price_ranges.present?
  }
  scope :by_tags, ->(tags) {
    if tags.present?
      tagged_recs = Recreation.joins(:tags).
                    where(tags: { name: tags }).
                    group('recreations.id').
                    having('COUNT(DISTINCT tags.id) = ?', tags.size).
                    select('recreations.id')
      where(id: tagged_recs)
    end
  }

  attribute :sort_order, :integer, default: 0
  enum :sort_order, {
    newest: 0,
    price_low_to_high: 1,
    price_high_to_low: 2,
    reviews_count: 3,
    number_of_recreations_held: 4
  }

  def flyer
    files = recreation_images.flyers&.to_a
    return nil if files.blank?

    files.first
  end

  def number_of_recreations_held
    orders.where(status: %i[unreported_completed final_report_admits_not finished invoice_issued paid]).size + number_of_past_events
  end

  def self.parse_price_ranges(price_ranges)
    price_ranges.map do |range|
      next unless range.include?('-')

      bounds = range.split('-').map(&:to_i)
      if range.end_with?('-')
        bounds[0]..Float::INFINITY
      else
        Range.new(*bounds)
      end
    end
  end
end
