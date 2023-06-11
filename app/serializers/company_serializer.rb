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
class CompanySerializer
  def serialize_list(companies:)
    companies.map { |company| serialize(company:) }
  end

  def serialize(company:)
    {
      id: company.id,
      facility_name: company.facility_name
    }
  end
end
