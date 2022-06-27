# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_informations
#
#  id           :bigint           not null, primary key
#  building     :string
#  city         :string           not null
#  code         :string
#  company_name :string           not null
#  email        :string           not null
#  memo         :string
#  name         :string           not null
#  prefecture   :string           not null
#  street       :string           not null
#  zip          :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_invoice_informations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :invoice_information do
    user
    name { 'エブリプラス' }
    code { '123456' }
    zip { '4536111' }
    prefecture { '愛知県' }
    city { '名古屋市' }
    street { '中村区名駅ＪＲセントラルタワーズ' }
    building { '' }
    memo { '' }
  end
end
