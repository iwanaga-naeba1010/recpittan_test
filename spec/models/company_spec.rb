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
#  nursing_care_level         :integer
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
require 'rails_helper'

RSpec.describe Company, type: :model do
end
