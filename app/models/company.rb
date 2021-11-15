# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id                         :bigint           not null, primary key
#  building                   :string
#  city                       :string
#  facility_name              :string
#  name                       :string
#  person_in_charge_name      :string
#  person_in_charge_name_kana :string
#  prefecture                 :string
#  street                     :string
#  tel                        :string
#  zip                        :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
class Company < ApplicationRecord
  has_many :users, dependent: :destroy

  has_one :plan, dependent: :destroy
  accepts_nested_attributes_for :plan, allow_destroy: true

  after_create :create_plan

  def create_plan
    build_plan(kind: :free)
    save
  end
end
