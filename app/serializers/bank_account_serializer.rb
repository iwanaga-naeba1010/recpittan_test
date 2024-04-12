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
class BankAccountSerializer
  def serialize(bank_account:)
    {
      id: bank_account.id,
      account_holder_name: bank_account.account_holder_name,
      account_number: bank_account.account_number,
      account_type: bank_account.account_type,
      bank_code: bank_account.bank_code,
      bank_name: bank_account.bank_name,
      branch_code: bank_account.branch_code,
      branch_name: bank_account.branch_name,
      user: bank_account.user
    }
  end
end
