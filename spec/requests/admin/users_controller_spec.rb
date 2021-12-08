# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:admin) { create :user, :with_admin }
  let!(:customer) { create :user, :with_custoemr }
  let(:partner) { create :user, :with_recreations }

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

  # TODO: 実装したらテストも記述する
  pending do
    describe 'POST #create' do
      let(:attrs) { attributes_for(:recreation, partner_id: partner.id) }

      context 'with valid parameters' do
        it 'return http success when user not logged in' do
          post admin_recreations_path, params: { recreation: attrs }
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(admin_recreation_path(Recreation.last.id))
        end

        it 'can create user_company and increase one record' do
          expect {
            post admin_recreations_path, params: { recreation: attrs }
          }.to change(Recreation, :count).by(+1)
        end
      end

      # TODO: 失敗パターンも実装
      context 'with invalid parameters' do
      end
    end
  end

  describe 'GET #edit' do
    it 'return http success' do
      get edit_admin_user_path(customer.id)
      expect(response).to have_http_status(:ok)
    end
  end

  # TODO: 実装したらテストも記述する
  pending do
    describe 'PUT #update' do
      context 'when valid parameters' do
        title = '修正後のrec'
        it 'returns 302 status' do
          put admin_recreation_path(recreation.id), params: { recreation: { title: title } }
          expect(response).to have_http_status(:found)
        end

        it 'update status' do
          expect {
            put admin_recreation_path(recreation.id), params: { recreation: { title: title } }
          }.to change { Recreation.find(recreation.id).title }.from(recreation.title).to(title)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'success' do
      it 'reduce one record' do
        expect { delete admin_user_path(customer.id) }.to change(User, :count).by(-1)
      end

      it 'redirects to managers company billboards path' do
        delete admin_user_path(customer.id)
        expect(response).to redirect_to admin_users_path
      end
    end
  end
end
