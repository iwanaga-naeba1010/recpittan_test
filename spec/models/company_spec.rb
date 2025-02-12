# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id                         :bigint           not null, primary key
#  building                   :string
#  capacity                   :integer
#  city                       :string
#  common_trading_target_code :string
#  facility_name              :string
#  facility_name_kana         :string
#  feature                    :text
#  genre                      :integer          default("residential_fee_based_nursing_home")
#  manage_company_code        :string
#  memo                       :string
#  name                       :string
#  nursing_care_level         :string
#  person_in_charge_name      :string
#  person_in_charge_name_kana :string
#  pref_code                  :string
#  prefecture                 :string
#  request                    :text
#  street                     :string
#  tel                        :string
#  trading_target_code        :string
#  url                        :string
#  zip                        :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
require 'rails_helper'

RSpec.describe Company, type: :model do
  it { is_expected.to have_db_column(:trading_target_code).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:pref_code).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:manage_company_code).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:common_trading_target_code).of_type(:string).with_options(null: true) }
end
