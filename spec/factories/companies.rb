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
#  genre                      :integer          default(0)
#  locality                   :string
#  name                       :string
#  nursing_care_level         :integer
#  person_in_charge_name      :string
#  person_in_charge_name_kana :string
#  phone                      :string
#  prefecture                 :string
#  region                     :string
#  request                    :text
#  street                     :string
#  tel                        :string
#  url                        :string
#  zip                        :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
FactoryBot.define do
  factory :company do
    user
    name { 'MyString' }
    facility_name { 'MyString' }
    person_in_charge_name { 'MyString' }
    person_in_charge_name_kana { 'MyString' }
    genre { :residential_fee_based_nursing_home }
    url { 'https://google.com' }
    feature { 'mystirng' }
    capacity { 20 }
    nursing_care_level { 3 }
  end
end
