# frozen_string_literal: true

module ApiCustomer
  class BankAccountsController < ApplicationController
    def create
      bank_account = Resources::BankAccounts::Create.run!(
        account_holder_name: params_create[:account_holder_name],
        account_number: params_create[:account_number],
        account_type: params_create[:account_type],
        bank_code: params_create[:bank_code],
        bank_name: params_create[:bank_name],
        branch_code: params_create[:branch_code],
        branch_name: params_create[:branch_name],
        user_id: params_create[:user_id]
      )
      render_json BankAccountSerializer.new.serialize(bank_account:)
    end

    private def params_create
      params.require(:bank_account).permit(
        :account_holder_name, :account_number, :account_type, :bank_code, :bank_name, :branch_code, :branch_name, :user_id
      )
    end
  end
end
