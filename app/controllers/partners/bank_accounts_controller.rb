# frozen_string_literal: true

class Partners::BankAccountsController < Partners::ApplicationController
  def new
    redirect_to edit_partners_bank_account_path if current_user.bank_account.present?
  end

  def edit
    redirect_to new_partners_bank_account_path if current_user.bank_account.blank?
  end
end
