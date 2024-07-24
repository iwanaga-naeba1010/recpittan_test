# frozen_string_literal: true

module Resources
  module BankAccounts
    class Update < ActiveInteraction::Base
      integer :id
      string :account_holder_name
      string :account_number
      string :account_type
      string :bank_code
      string :bank_name
      string :branch_code
      string :branch_name

      validates :id, presence: true

      def execute
        bank_account = BankAccount.find(id)
        bank_account.update!(
          account_holder_name:,
          account_number:,
          account_type:,
          bank_code:,
          bank_name:,
          branch_code:,
          branch_name:
        )
        bank_account
      end
    end
  end
end
