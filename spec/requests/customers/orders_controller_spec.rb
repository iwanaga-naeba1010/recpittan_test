# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe Customers::OrdersController, type: :request do
  let(:user) { create :user, :with_customer }
  let(:partner) { create :user, :with_recreations }
  let(:recreation) { partner.recreations.first }
  let(:order) { create :order, :with_order_dates, recreation_id: recreation.id, user_id: user.id }

  before do
    sign_in user
  end

  # NOTE: 事前にEmailTemplateを用意する必要あるため、設定
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
    context 'with valid parameters' do
      let(:order_attrs) {
        attributes_for(:order, recreation_id: recreation.id, user_id: user.id,
                               order_dates_attributes: [
                                 { year: '2030', month: '1', date: '1', start_hour: '13', start_minute: '00', end_hour: '14', end_minute: '30' },
                                 { year: '2030', month: '1', date: '2', start_hour: '13', start_minute: '30', end_hour: '14', end_minute: '30' },
                                 { year: '2030', month: '1', date: '3', start_hour: '13', start_minute: '30', end_hour: '14', end_minute: '30' }
                               ])
      }

      it 'return http success when user not logged in' do
        post customers_recreation_orders_path(recreation), params: { order: order_attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(chat_customers_order_path(Order.last.id))
      end
    end

    context 'with invalid parameters' do
      let(:order_attrs) {
        attributes_for(:order, recreation_id: recreation.id, user_id: user.id,
                               order_dates_attributes: [
                                 { year: '2022', month: '1', date: '1', start_hour: '13', start_minute: '00', end_hour: '14', end_minute: '30' },
                                 { year: '2022', month: '1', date: '2', start_hour: '13', start_minute: '30', end_hour: '14', end_minute: '30' },
                                 { year: '2022', month: '1', date: '3', start_hour: '13', start_minute: '30', end_hour: '14', end_minute: '30' }
                               ])
      }

      it 'return http success when user not logged in' do
        post customers_recreation_orders_path(recreation), params: { order: order_attrs }
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get customers_order_path(order)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /chat' do
    it 'returns http success' do
      get chat_customers_order_path(order)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /complete' do
    context 'with valid order status' do
      it 'returns http success' do
        order.update(start_at: Time.current)
        get complete_customers_order_path(order)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid order status' do
      it 'redirects to chat path' do
        get complete_customers_order_path(order)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to chat_customers_order_path(order)
      end
    end
  end
end
