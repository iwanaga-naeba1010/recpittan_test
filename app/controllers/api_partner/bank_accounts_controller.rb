# frozen_string_literal: true

module ApiPartner
  class BankAccountsController < ApplicationController
    def show
      bank_account = BankAccount.find_by(user_id: current_user.id)
      render json: BankAccountSerializer.new.serialize(bank_account:)
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
      render json: BankAccountSerializer.new.serialize(bank_account:)
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
      Sentry.capture_exception(e)
    end

    def update
      bank_account_id = BankAccount.find_by!(user_id: current_user.id).id
      bank_account = Resources::BankAccounts::Update.run!(
        id: bank_account_id,
        account_holder_name: params_update[:account_holder_name],
        account_number: params_update[:account_number],
        account_type: params_update[:account_type],
        bank_code: params_update[:bank_code],
        bank_name: params_update[:bank_name],
        branch_code: params_update[:branch_code],
        branch_name: params_update[:branch_name],
        is_corporate: params_update[:is_corporate],
        corporate_type_code: params_update[:corporate_type_code],
        is_foreignresident: params_update[:is_foreignresident],
        investments: params_update[:investments],
        is_invoice: params_update[:is_invoice],
        invoice_number: params_update[:invoice_number]
      )
      render json: BankAccountSerializer.new.serialize(bank_account:)
    end

    private

    def params_create
      params.require(:bank_account).permit(
        :account_holder_name, :account_number, :account_type, :bank_code, :bank_name, :branch_code, :branch_name
      )
    end

    def params_update
      params.require(:bank_account).permit(
        :account_holder_name, :account_number, :account_type, :bank_code, :bank_name, :branch_code, :branch_name,
        :is_corporate, :corporate_type_code, :is_foreignresident, :investments, :is_invoice, :invoice_number
      )
    end
  end
end
