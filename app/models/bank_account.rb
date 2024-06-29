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
class BankAccount < ApplicationRecord
  encrypts :account_holder_name, :account_number, :account_type, :bank_code, :bank_name, :branch_code, :branch_name

  belongs_to :user

  validates :account_holder_name, :account_number, :account_type, :bank_code, :bank_name, :branch_code, :branch_name, presence: true
  validates :account_number, uniqueness: { scope: :user_id },
                             format: { with: /\A\d+\z/, message: I18n.t('active_interaction.errors.messages.invalid_account_number') }
  validates :bank_code, format: { with: /\A\d{4}\z/, message: I18n.t('active_interaction.errors.messages.invalid_bank_code') }
  validates :branch_code, format: { with: /\A\d{3}\z/, message: I18n.t('active_interaction.errors.messages.invalid_branch_code') }
  validates :account_holder_name,
            format: { with: /\A[\p{katakana}ー－]+\z/,
                      message: I18n.t('active_interaction.errors.messages.only_katakana') }
end
