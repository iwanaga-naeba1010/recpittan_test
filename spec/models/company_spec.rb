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
require 'rails_helper'

RSpec.describe Company, type: :model do
  it 'create a plan record after created' do
    company = create :company
    expect(company.plan.id).not_to be nil
    expect(company.plan.kind).to eq :free
  end
end
