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
#  instructor_description  :text
#  instructor_image        :text
#  instructor_name         :string
#  instructor_position     :string
#  instructor_title        :string
#  is_online               :boolean          default(FALSE)
#  is_public               :boolean
#  is_public_price         :boolean          default(TRUE)
#  material_amount         :integer
#  material_price          :integer
#  minutes                 :integer
#  prefectures             :string           default([]), is an Array
#  price                   :integer
#  second_title            :string
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
  mount_uploader :instructor_image, ImageUploader

  belongs_to :user

  has_many :recreation_tags, dependent: :destroy
  has_many :tags, through: :recreation_tags

  has_many :recreation_images, dependent: :destroy
  accepts_nested_attributes_for :recreation_images, allow_destroy: true

  has_many :orders, dependent: :destroy

  has_one :recreation_profile, dependent: :destroy
  has_one :profile, through: :recreation_profile
  accepts_nested_attributes_for :recreation_profile, allow_destroy: true

  delegate :name, :title, :description, :image, to: :partner, prefix: true, allow_nil: true
  delegate :name, :title, :description, :image, to: :profile, prefix: true, allow_nil: true

  scope :public_recs, -> { where(is_public: true) }

  enumerize :category, in: { event: 0, work: 1, music: 2, health: 3, travel: 4, hobby: 5, food: 6, other: 7 }, default: 0

  def flyer
    files = recreation_images.flyers&.to_a
    return nil if files.blank?

    files.first
  end
end
