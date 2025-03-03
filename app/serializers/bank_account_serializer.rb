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
#  corporate_number    :string
#  corporate_type_code :string
#  investments         :integer
#  invoice_number      :string
#  is_corporate        :boolean          default(FALSE)
#  is_foreignresident  :boolean          default(FALSE)
#  is_invoice          :boolean          default(FALSE)
#  is_subcontract      :boolean          default(FALSE)
#  my_number           :string
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
      is_corporate: bank_account.is_corporate,
      corporate_type_code: bank_account.corporate_type_code,
      is_foreignresident: bank_account.is_foreignresident,
      investments: bank_account.investments,
      is_invoice: bank_account.is_invoice,
      invoice_number: bank_account.invoice_number,
      corporate_number: bank_account.corporate_number,
      my_number: bank_account.my_number,
      is_subcontract: bank_account.is_subcontract,
      user: bank_account.user
    }
  end
end
