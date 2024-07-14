# frozen_string_literal: true

module ApiPartner
  class BankAccountsController < ApplicationController
    def show
      bank_account = BankAccount.find_by(user_id: current_user.id)
      render_json BankAccountSerializer.new.serialize(bank_account:)
    end

    def create
      bank_account = Resources::BankAccounts::Create.run!(
        account_holder_name: params_create[:account_holder_name],
        account_number: params_create[:account_number],
        account_type: params_create[:account_type],
        bank_code: params_create[:bank_code],
        bank_name: params_create[:bank_name],
        branch_code: params_create[:branch_code],
        branch_name: params_create[:branch_name],
        user_id: current_user.id
      )
      render_json BankAccountSerializer.new.serialize(bank_account:)
    end

    def update
      bank_account = Resources::BankAccounts::Update.run!(
        id: params[:id],
        account_holder_name: params_update[:account_holder_name],
        account_number: params_update[:account_number],
        account_type: params_update[:account_type],
        bank_code: params_update[:bank_code],
        bank_name: params_update[:bank_name],
        branch_code: params_update[:branch_code],
        branch_name: params_update[:branch_name]
      )
      render_json BankAccountSerializer.new.serialize(bank_account:)
    end

    private

    def params_create
      params.require(:bank_account).permit(
        :account_holder_name, :account_number, :account_type, :bank_code, :bank_name, :branch_code, :branch_name
      )
    end

    def params_update
      params.require(:bank_account).permit(
        :account_holder_name, :account_number, :account_type, :bank_code, :bank_name, :branch_code, :branch_name
      )
    end
  end
end
