# frozen_string_literal: true

# == Schema Information
#
# Table name: bank_accounts
#
#  id                  :bigint           not null, primary key
#  account_holder_name :string           not null
#  account_number      :string           not null
#  account_type        :string           not null
#  bank_code           :string           not null
#  bank_name           :string           not null
#  branch_code         :string           not null
#  branch_name         :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_bank_accounts_on_user_id                     (user_id)
#  index_bank_accounts_on_user_id_and_account_number  (user_id,account_number) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :bank_account do
    user
    bank_name { 'MyString' }
    bank_code { '0001' }
    branch_name { 'MyString' }
    branch_code { '001' }
    account_type { 'MyString' }
    account_number { '000001' }
    account_holder_name { 'ナマエタロウ' }
  end
end
