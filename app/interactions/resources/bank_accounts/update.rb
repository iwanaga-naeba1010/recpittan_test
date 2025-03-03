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
      boolean :is_corporate, default: false
      string :corporate_type_code, default: nil
      boolean :is_foreignresident, default: false
      integer :investments, default: nil
      boolean :is_invoice, default: false
      string :invoice_number, default: nil

      validates :id, presence: true
      validates :account_holder_name, presence: true
      validates :account_number, presence: true
      validates :account_type, presence: true
      validates :bank_code, presence: true
      validates :bank_name, presence: true
      validates :branch_code, presence: true
      validates :branch_name, presence: true

      def execute
        bank_account = BankAccount.find(id)
        bank_account.update!(
          account_holder_name:,
          account_number:,
          account_type:,
          bank_code:,
          bank_name:,
          branch_code:,
          branch_name:,
          is_corporate:,
          corporate_type_code:,
          is_foreignresident:,
          investments:,
          is_invoice:,
          invoice_number:
        )
        bank_account
      end
    end
  end
end
