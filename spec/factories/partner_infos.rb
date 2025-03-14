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
#  pref_code    :string
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
    user
    postal_code { '454-0000' }
    prefecture { '愛知県' }
    city { '名古屋市' }
    address1 { '中村区名駅1' }
    address2 { '1-1' }
    company_name { 'company_name' }
  end
end
