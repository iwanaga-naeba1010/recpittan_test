# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiCustomer::Orders::ChatsController, type: :request do
  let(:customer) { create :user, :with_custoemr }
  let(:order) { create :order, user: customer }
  let(:chat) { create :chat, user: customer, order: order }

  before do
    sign_in customer
  end

  describe 'GET /' do
    context 'with valid user' do
      it 'return http success' do
        get api_customer_order_chats_path(order)
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'POST /create' do
    let(:attrs) { attributes_for(:chat, order_id: order.id, user: customer) }

    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post api_customer_order_chats_path(order), params: { chat: attrs }
        expect(response.status).to eq 200
      end
    end

    # TODO: 失敗パターンも実装
    context 'with invalid parameters' do
    end
  end
end
