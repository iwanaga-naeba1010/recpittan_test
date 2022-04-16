# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiCustomer::OrdersController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_custoemr }
  let(:recreation) { partner.recreations.first }
  let(:order) { create :order, recreation_id: recreation.id, user_id: customer.id }

  before do
    sign_in customer
  end

  describe 'GET /' do
    context 'with valid parameters' do
      it 'return http success' do
        get api_customer_order_path(order)
        # json = JSON.parse(response.body)
        expect(response.status).to eq(200)
        # expect(json['data']['title']).to eq(post.title)
      end
    end
  end

  describe 'PUT /update' do
    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        put api_customer_order_path(order), params: { order: { transportation_expenses: 1000 } }
        expect(response.status).to eq 200
      end

      it 'update transportation_expenses' do
        expect {
          put api_customer_order_path(order), params: { order: { transportation_expenses: 1000 } }
        }.to change { Order.find(order.id).transportation_expenses }.from(order.transportation_expenses).to(1000)
      end

      it 'update expenses' do
        expect {
          put api_customer_order_path(order), params: { order: { expenses: 1000 } }
        }.to change { Order.find(order.id).expenses }.from(order.expenses).to(1000)
      end
    end

    # TODO: 失敗パターンも実装
    context 'with invalid parameters' do
    end
  end
end
