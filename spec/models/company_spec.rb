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
require 'rails_helper'

RSpec.describe Company, type: :model do
  it 'create a plan record after created' do
    company = create :company
    expect(company.plan.id).not_to be nil
    expect(company.plan.kind).to eq :free
  end
end
