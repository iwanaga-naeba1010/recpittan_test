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
  extend Enumerize
  # mount_uploader :instructor_image, ImageUploader

  enumerize :kind, in: { visit: 0, online: 1, mailing: 2 }, default: 0
  enumerize :status, in: { unapplied: 0, in_progress: 1, published: 2 }, default: 0
  enumerize :category, in: { event: 0, work: 1, music: 2, health: 3, travel: 4, hobby: 5, food: 6, other: 7 }, default: 0

  belongs_to :user
  has_many :recreation_tags, dependent: :destroy
  has_many :tags, through: :recreation_tags
  has_many :recreation_images, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :recreation_profile, dependent: :destroy
  has_one :profile, through: :recreation_profile
  has_many :recreation_prefectures, dependent: :destroy

  accepts_nested_attributes_for :recreation_images, allow_destroy: true
  accepts_nested_attributes_for :recreation_profile, allow_destroy: true
  accepts_nested_attributes_for :recreation_prefectures, allow_destroy: true

  delegate :name, :title, :description, :image, to: :partner, prefix: true, allow_nil: true
  delegate :name, :title, :description, :image, to: :profile, prefix: true, allow_nil: true

  # NOTE(okubo): publicは予約後なので下記で定義
  scope :public_recs, -> { where(status: :published) }

  def flyer
    files = recreation_images.flyers&.to_a
    return nil if files.blank?

    files.first
  end
end
