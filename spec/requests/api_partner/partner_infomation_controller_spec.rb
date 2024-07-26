# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiPartner::PartnerInformationController, type: :request do
  include_context 'with authenticated partner'

  describe 'GET /api_partner/partner_information/:id' do
    let(:user) { create(:user, :with_partner) }

    context 'when partner_info exists' do
      let!(:partner_info) { create(:partner_info, user:) }

      before { get api_partner_partner_information_path(user) }

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the user information' do
        json_response = response.parsed_body
        expect(json_response['id']).to eq(user.id)
        expect(json_response['username']).to eq(user.username)
        expect(json_response['username_kana']).to eq(user.username_kana)
        expect(json_response['partner_info']['phone_number']).to eq(user.partner_info.phone_number)
      end
    end

    context 'when partner_info does not exist' do
      before { get api_partner_partner_information_path(user) }

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns user information with null partner_info' do
        json_response = response.parsed_body
        expect(json_response['id']).to eq(user.id)
        expect(json_response['username']).to eq(user.username)
        expect(json_response['username_kana']).to eq(user.username_kana)
        expect(json_response['partner_info']).to be_nil
      end
    end
  end

  describe 'PUT /api_partner/partner_information/:id' do
    let(:user) { create(:user, :with_partner) }

    context 'when partner_info exists' do
      let!(:partner_info) { create(:partner_info, user:) }
      let(:params) do
        {
          user: {
            username: '山田太郎',
            username_kana: 'ヤマダタロウ',
            partner_info_attributes: {
              phone_number: '08012345678',
              postal_code: '7654321',
              prefecture: '大阪府',
              city: '大阪市',
              address1: '梅田',
              address2: '',
              company_name: '株式会社例'
            }
          }
        }
      end

      before { put api_partner_partner_information_path(user), params: }

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'updates the user information' do
        user.reload
        expect(user.username).to eq('山田太郎')
        expect(user.username_kana).to eq('ヤマダタロウ')
        expect(user.partner_info.phone_number).to eq('08012345678')
      end
    end

    context 'when partner_info does not exist' do
      let(:params) do
        {
          user: {
            username: '山田太郎',
            username_kana: 'ヤマダタロウ',
            partner_info_attributes: {
              phone_number: '08012345678',
              postal_code: '7654321',
              prefecture: '大阪府',
              city: '大阪市',
              address1: '梅田',
              address2: '',
              company_name: '株式会社例'
            }
          }
        }
      end

      before { put api_partner_partner_information_path(user), params: }

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'creates and updates partner_info' do
        user.reload
        expect(user.username).to eq('山田太郎')
        expect(user.username_kana).to eq('ヤマダタロウ')
        expect(user.partner_info.phone_number).to eq('08012345678')
      end
    end
  end
end
