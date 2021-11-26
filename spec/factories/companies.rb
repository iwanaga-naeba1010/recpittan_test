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
FactoryBot.define do
  factory :company do
    user
    name { 'MyString' }
    facility_name { 'MyString' }
    person_in_charge_name { 'MyString' }
    person_in_charge_name_kana { 'MyString' }
  end
end
