# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id                         :bigint           not null, primary key
#  building                   :string
#  capacity                   :integer
#  city                       :string
#  facility_name              :string
#  facility_name_kana         :string
#  feature                    :text
#  genre                      :integer          default("residential_fee_based_nursing_home")
#  memo                       :string
#  name                       :string
#  nursing_care_level         :string
#  person_in_charge_name      :string
#  person_in_charge_name_kana :string
#  prefecture                 :string
#  request                    :text
#  street                     :string
#  tel                        :string
#  url                        :string
#  zip                        :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class Company < ApplicationRecord
  include PrefectureList

  extend Enumerize

  # NOTE: 現状1名のUserしか想定していないためhas_one。複数に対応させる場合は、has_manyに変更でいける
  has_one :user, dependent: :destroy, class_name: 'User'
  accepts_nested_attributes_for :user, allow_destroy: true

  has_one :channel_plan_subscriber, dependent: :destroy, class_name: 'ChannelPlanSubscriber'
  accepts_nested_attributes_for :channel_plan_subscriber, allow_destroy: true

  has_many :company_tags, dependent: :destroy, class_name: 'CompanyTag'
  has_many :tags, through: :company_tags, class_name: 'Tag'
  has_many :company_memos, dependent: :destroy, class_name: 'CompanyMemo'

  validates :name, :facility_name, presence: true

  delegate :email, to: :user, prefix: true, allow_nil: true

  attribute :user_company_id

  scope :without_channel_subscribe, -> { includes(:channel_plan_subscriber).where(channel_plan_subscriber: { id: nil }) }

  enumerize :genre, in: {
    residential_fee_based_nursing_home: 0,
    general_care: 1, serviced_senior_housing: 2,
    private_pay_nursing_home_with_nursing_care_services: 3,
    group_home: 4, intensive_care_old_peoples_home: 5,
    rehabilitation_for_the_aged: 6, short_stay: 7, other: 8
  }, default: 0

  def full_address
    "#{prefecture}#{city}#{street}#{building}"
  end
end
