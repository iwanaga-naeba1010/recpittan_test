# frozen_string_literal: true

# == Schema Information
#
# Table name: partner_infos
#
#  id           :bigint           not null, primary key
#  address1     :string
#  address2     :string
#  city         :string
#  company_name :string
#  phone_number :string
#  postal_code  :string
#  prefecture   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_partner_infos_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :partner_info do
    user { nil }
    postal_code { 'MyString' }
    prefecture { 'MyString' }
    city { 'MyString' }
    address1 { 'MyString' }
    address2 { 'MyString' }
    company_name { 'MyString' }
  end
end
