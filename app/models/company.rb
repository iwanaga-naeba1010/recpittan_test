# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id                         :bigint           not null, primary key
#  address                    :string
#  building                   :string
#  city                       :string
#  facility_name              :string
#  locality                   :string
#  name                       :string
#  person_in_charge_name      :string
#  person_in_charge_name_kana :string
#  phone                      :string
#  prefecture                 :string
#  region                     :string
#  street                     :string
#  tel                        :string
#  zip                        :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class Company < ApplicationRecord
  # NOTE: 現状1名のUserしか想定していないためhas_one。複数に対応させる場合は、has_manyに変更でいける
  has_one :user, dependent: :destroy
  accepts_nested_attributes_for :user, allow_destroy: true

  has_one :plan, dependent: :destroy
  accepts_nested_attributes_for :plan, allow_destroy: true

  after_create :create_plan

  validates :name, :facility_name, presence: true

  def create_plan
    build_plan(kind: :free)
    save
  end
end
