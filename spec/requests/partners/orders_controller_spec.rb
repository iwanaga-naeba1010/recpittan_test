# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::OrdersController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_custoemr }
  let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }

  before do
    sign_in partner
  end

  describe 'GET /show' do
    context 'with valid user' do
      it 'return http success' do
        get partners_order_path(order.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid user' do
      it 'return 302 when customer accessed' do
        sign_out partner
        sign_in customer
        get partners_order_path(order.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end

      it 'return 302 when user not logged in' do
        sign_out partner
        get partners_order_path(order.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /chat' do
    context 'with valid user' do
      it 'return http success' do
        get chat_partners_order_path(order.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid user' do
      it 'return 302 when customer accessed' do
        sign_out partner
        sign_in customer
        get chat_partners_order_path(order.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end

      it 'return 302 when user not logged in' do
        sign_out partner
        get chat_partners_order_path(order.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /confirm' do
    context 'with valid user' do
      it 'return http success' do
        get confirm_partners_order_path(order.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid user' do
      it 'return 302 when customer accessed' do
        sign_out partner
        sign_in customer
        get confirm_partners_order_path(order.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end

      it 'return 302 when user not logged in' do
        sign_out partner
        get confirm_partners_order_path(order.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
