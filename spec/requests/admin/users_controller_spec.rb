# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:admin) { create :user, :with_admin }
  let(:customer) { create :user, :with_customer }
  let!(:partner) { create :user, :with_recreations }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'return http success' do
      get admin_users_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'return http success' do
      get admin_user_path(customer.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    let(:attrs) { attributes_for(:user) }

    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post admin_users_path, params: { user: attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(admin_user_path(User.where(role: :customer).last.id))
      end

      it 'can create partner' do
        expect {
          post admin_users_path, params: { user: attrs }
        }.to change(User, :count).by(+1)
      end

      it 'can create user with partner role' do
        post admin_users_path, params: { user: attrs }
        expect(User.last.role).to eq :customer
      end
    end

    # TODO: 失敗パターンも実装
    context 'with invalid parameters' do
    end
  end

  describe 'GET #edit' do
    it 'return http success' do
      get edit_admin_user_path(partner.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update' do
    context 'when valid parameters' do
      username = 'test'
      it 'returns 302 status' do
        put admin_user_path(partner.id), params: { user: { username: } }
        expect(response).to have_http_status(:found)
      end

      it 'update status' do
        expect {
          put admin_user_path(partner.id), params: { user: { username: } }
        }.to change { User.where(role: :partner).find(partner.id).username }.from(partner.username).to(username)
      end

      it 'update email' do
        email = 'hogehogehoge@example.com'
        expect {
          put admin_user_path(partner.id), params: { user: { email: } }
        }.to change { User.where(role: :partner).find(partner.id).email }.from(partner.email).to(email)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'success' do
      it 'reduce one record' do
        expect { delete admin_user_path(partner.id) }.to change(User, :count).by(-1)
      end

      it 'redirects to managers company billboards path' do
        delete admin_user_path(partner.id)
        expect(response).to redirect_to admin_users_path
      end
    end
  end
end
