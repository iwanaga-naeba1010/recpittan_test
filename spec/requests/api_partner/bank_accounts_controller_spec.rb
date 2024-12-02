# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiPartner::BankAccountsController, type: :request do
  include_context 'with authenticated partner'

  describe 'POST /api_partner/bank_accounts' do
    let(:params) do
      {
        bank_account: {
          account_holder_name: 'ナマエタロウ',
          account_number: '0000000',
          account_type: 'checking',
          bank_code: '0000',
          bank_name: '名古屋銀行',
          branch_code: '000',
          branch_name: '名古屋支点',
          user_id: current_user.id,
        }
      }
    end

    let(:expected) { BankAccountSerializer.new.serialize(evaluation_reply: BankAccount.last) }

    it_behaves_like 'an endpoint returns 2xx status', :expected

    context 'with invalid params' do
      let(:params) do
        {
          bank_account: {
            account_holder_name: 'invalid_name',
            account_number: '0000000',
            account_type: 'invalid',
            bank_code: '0000',
            bank_name: '名古屋銀行',
            branch_code: '000',
            branch_name: '名古屋支点',
            user_id: current_user.id
          }
        }
      end

      it 'returns a 422 status with error messages' do
        post '/api_partner/bank_accounts', params: params
        expect(response.status).to eq(422)
        expect(response.parsed_body['error']).to include('預金種目は一覧にありません', '口座名義はカタカナのみで入力してください')
      end
    end
  end
end
