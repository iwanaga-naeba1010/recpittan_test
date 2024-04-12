# frozen_string_literal: true

module Resources
  module BankAccounts
    class Create < ActiveInteraction::Base
      string :account_holder_name
      string :account_number
      string :account_type
      string :bank_code
      string :bank_name
      string :branch_code
      string :branch_name
      integer :user_id

      validates :account_holder_name, :account_number, :account_type, :bank_code, :bank_name, :branch_code, :branch_name, presence: true

      def execute
        BankAccount.create!(account_holder_name:, account_number:, account_type:,
                            bank_code:, bank_name:, branch_code:, branch_name:, user_id:)
      end
    end
  end
end
