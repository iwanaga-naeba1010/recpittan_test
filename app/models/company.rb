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
#  feature                    :text
#  genre                      :integer          default("residential_fee_based_nursing_home")
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
  extend Enumerize
  # NOTE: 現状1名のUserしか想定していないためhas_one。複数に対応させる場合は、has_manyに変更でいける
  has_one :user, dependent: :destroy
  accepts_nested_attributes_for :user, allow_destroy: true

  has_many :company_tags, dependent: :destroy
  has_many :tags, through: :company_tags

  validates :name, :facility_name, presence: true

  delegate :email, to: :user, prefix: true, allow_nil: true

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
