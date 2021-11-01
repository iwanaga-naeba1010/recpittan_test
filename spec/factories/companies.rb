# == Schema Information
#
# Table name: companies
#
#  id                         :bigint           not null, primary key
#  facility_name              :string
#  name                       :string
#  person_in_charge_name      :string
#  person_in_charge_name_kana :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  user_id                    :bigint           not null
#
# Indexes
#
#  index_companies_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :company do
    name { "MyString" }
    facility_name { "MyString" }
    person_in_charge_name { "MyString" }
    person_in_charge_name_kana { "MyString" }
    user { nil }
  end
end
