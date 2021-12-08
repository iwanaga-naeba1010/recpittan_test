# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Partners', type: :request do
  let(:admin) { create :user, :with_admin }
  let(:customer) { create :user, :with_custoemr }
  let!(:partner) { create :user, :with_recreations }
  # let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'return http success' do
      get admin_partners_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'return http success' do
      get admin_partner_path(partner.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    let(:attrs) { attributes_for(:user) }

    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post admin_partners_path, params: { partner: attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(admin_partner_path(User.where(role: :partner).last.id))
      end

      it 'can create partner' do
        expect {
          post admin_partners_path, params: { partner: attrs }
        }.to change(User, :count).by(+1)
      end

      # it 'can create partner and increase one user record' do
      #   expect {
      #     post admin_partners_path, params: { partner: attrs }
      #   }.to change(User, :count).by(+1)
      # end

      it 'can create user with partner role' do
        post admin_partners_path, params: { partner: attrs }
        expect(User.last.role).to eq :partner
      end
    end

    # TODO: 失敗パターンも実装
    context 'with invalid parameters' do
    end
  end

  describe 'GET #edit' do
    it 'return http success' do
      get edit_admin_partner_path(partner.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update' do
    context 'when valid parameters' do
      username = 'test'
      it 'returns 302 status' do
        put admin_partner_path(partner.id), params: { partner: { username: username } }
        expect(response).to have_http_status(:found)
      end

      it 'update status' do
        expect {
          put admin_partner_path(partner.id), params: { partner: { username: username } }
        }.to change { User.where(role: :partner).find(partner.id).username }.from(partner.username).to(username)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'success' do
      it 'reduce one record' do
        expect { delete admin_partner_path(partner.id) }.to change(User, :count).by(-1)
      end

      it 'redirects to managers company billboards path' do
        delete admin_partner_path(partner.id)
        expect(response).to redirect_to admin_partners_path
      end
    end
  end
end
