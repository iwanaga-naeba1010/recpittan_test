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
class BankAccount < ApplicationRecord
  include Ransackable
  extend Enumerize

  belongs_to :user, class_name: 'User', inverse_of: :bank_account

  validates :account_holder_name, :account_number, :account_type, :bank_code, :bank_name, :branch_code, :branch_name, presence: true
  validates :account_number, uniqueness: { scope: :user_id },
                             format: { with: /\A\d+\z/, message: I18n.t('active_interaction.errors.messages.invalid_account_number') }
  validates :bank_code, format: { with: /\A\d{4}\z/, message: I18n.t('active_interaction.errors.messages.invalid_bank_code') }
  validates :branch_code, format: { with: /\A\d{3}\z/, message: I18n.t('active_interaction.errors.messages.invalid_branch_code') }
  validates :account_holder_name,
            format: { with: /\A[\p{katakana}ー－]+\z/,
                      message: I18n.t('active_interaction.errors.messages.only_katakana') }

  enumerize :account_type, in: %i[checking current], default: :checking, predicates: true, scope: true

  delegate :username, to: :user, prefix: true
end
