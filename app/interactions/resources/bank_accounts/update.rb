# frozen_string_literal: true

module Resources
  module BankAccounts
    class Update < ActiveInteraction::Base
      integer :id
      string :account_holder_name, default: nil
      string :account_number, default: nil
      string :account_type, default: nil
      string :bank_code, default: nil
      string :bank_name, default: nil
      string :branch_code, default: nil
      string :branch_name, default: nil

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
