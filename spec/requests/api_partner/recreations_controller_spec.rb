# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiPartner::RecreationsController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:profile) { create :profile, user: partner }
  let(:recreation) { partner.recreations.first }

  before do
    sign_in partner
  end

  describe 'GET /config_data' do
    context 'with valid parameters' do
      it 'return http success' do
        get config_data_api_partner_recreations_path
        json = JSON.parse(response.body)['categories']
        expect(response.status).to eq(200)
        expect(json).to eq %w[イベント 創作 音楽 健康 旅行 趣味 食べ物 その他]
      end
    end
  end

  describe 'GET /:id' do
    context 'with valid parameters' do
      it 'return http success' do
        get api_partner_recreation_path(recreation)
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let(:attrs) do
        attributes_for(
          :recreation,
          user: partner,
          recreation_profile_attributes: { profile_id: profile.id }
        )
      end

      it 'returns http success with valid params' do
        post api_partner_recreations_path, params: { recreation: attrs }
        expect(response.status).to eq 200
      end

      # it 'saves unapplied status when create method' do
      #   post api_partner_recreations_path, params: { recreation: attrs }
      #   expect(Recreation.last.status).to eq 'unapplied'
      # end
      #
      # it 'creates recreation record' do
      #   post api_partner_recreations_path, params: { recreation: attrs }
      #   expect {
      #     post api_partner_recreations_path, params: { recreation: attrs }
      #   }.to change(Recreation, :count).by(+1)
      # end
      #
      # it 'creates recreation_profile record' do
      #   post api_partner_recreations_path, params: { recreation: attrs }
      #   expect {
      #     post api_partner_recreations_path, params: { recreation: attrs }
      #   }.to change(RecreationProfile, :count).by(+1)
      # end
    end

    # context 'with invalid parameters' do
    #   it 'returns 422 status when recreation_profile is blank' do
    #     post api_partner_recreations_path, params: { recreation: attributes_for(:recreation, user: partner) }
    #     expect(response.status).to eq 422
    #   end
    # end
  end

  describe 'PUT /update' do
    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        put api_partner_recreation_path(recreation),
            params: { recreation: { title: 'title' } }
        expect(response.status).to eq 200
      end
    end

    # TODO: 失敗パターンも実装
    context 'with invalid parameters' do
    end
  end
end
