# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customers::OrdersController, type: :request do
  let(:user) { create :user, :with_custoemr }
  let(:partner) { (create :user, :with_partner).partner }
  let(:recreation) { partner.recreations.first }
  let(:order) { create :order, recreation_id: recreation.id, user_id: user.id }

  before do
    sign_in user
  end

  describe 'GET /new' do
    context 'with valid user' do
      it 'return http success' do
        get new_customers_recreation_order_path(recreation)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid user' do
      it 'return http success when user not logged in' do
        sign_out user
        get new_customers_recreation_order_path(recreation)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # TODO: テスト書きたいが、エラー出て時間かかりそうなので一旦スルー
  describe 'POST /create' do
    let(:order_attrs) { attributes_for(:order, recreation_id: recreation.id, user_id: user.id) }

    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post customers_recreation_orders_path(recreation), params: { order: order_attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(chat_customers_order_path(Order.last.id))
      end
    end

    it 'return http success when user not logged in' do
      get customers_recreation_path(recreation)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /chat' do
    it 'returns http success' do
      get chat_customers_order_path(order)
      expect(response).to have_http_status(:ok)
    end
  end
end
