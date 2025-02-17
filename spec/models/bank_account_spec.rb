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
#  is_corporate        :boolean          default(FALSE), not null
#  is_foreignresident  :boolean          default(FALSE), not null
#  is_invoice          :boolean          default(FALSE), not null
#  is_subcontract      :boolean          default(FALSE), not null
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
require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    {
      user_id: user.id,
      account_holder_name: 'ナマエタロウ',
      account_number: '1234567890',
      account_type: 'checking',
      bank_code: '0001',
      bank_name: 'テスト銀行',
      branch_code: '001',
      branch_name: 'テスト支店'
    }
  end
  let(:bank_account) { BankAccount.new(valid_attributes) }

  it { is_expected.to have_db_column(:is_corporate).of_type(:boolean).with_options(default: false, null: false) }
  it { is_expected.to have_db_column(:corporate_type_code).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:is_foreignresident).of_type(:boolean).with_options(default: false, null: false) }
  it { is_expected.to have_db_column(:investments).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:is_invoice).of_type(:boolean).with_options(default: false, null: false) }
  it { is_expected.to have_db_column(:invoice_number).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:corporate_number).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:my_number).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:is_subcontract).of_type(:boolean).with_options(default: false, null: false) }

  describe 'validations' do
    it 'is valid with all valid attributes' do
      expect(bank_account).to be_valid
    end

    context 'bank code validations' do
      it 'is invalid with non-numeric bank code' do
        bank_account.bank_code = 'ABCD'
        bank_account.valid?
        expect(bank_account.errors[:bank_code]).to include('金融機関コードは半角4桁の数字で入力してください')
      end

      it 'is invalid with incorrect length of bank code' do
        bank_account.bank_code = '12345'
        bank_account.valid?
        expect(bank_account.errors[:bank_code]).to include('金融機関コードは半角4桁の数字で入力してください')
      end
    end

    context 'branch code validations' do
      it 'is invalid with non-numeric branch code' do
        bank_account.branch_code = 'XYZ'
        bank_account.valid?
        expect(bank_account.errors[:branch_code]).to include('支店コードは半角3桁の数字で入力してください')
      end

      it 'is invalid with incorrect length of branch code' do
        bank_account.branch_code = '1234'
        bank_account.valid?
        expect(bank_account.errors[:branch_code]).to include('支店コードは半角3桁の数字で入力してください')
      end
    end

    context 'account number validations' do
      it 'is invalid with non-numeric account number' do
        bank_account.account_number = 'ABCDEF'
        bank_account.valid?
        expect(bank_account.errors[:account_number]).to include('口座番号は半角数字のみで入力してください')
      end
    end
  end
end
