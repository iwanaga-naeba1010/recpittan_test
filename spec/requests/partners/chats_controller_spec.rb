# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::ChatsController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_custoemr }
  let(:recreation) { partner.recreations.first }
  let(:order) { create :order, recreation_id: recreation.id, user_id: customer.id }

  before do
    sign_in partner
  end

  describe 'POST /create' do
    let(:chat_attrs) { attributes_for(:chat, order_id: order.id) }

    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post partners_chats_path(recreation.id), params: { chat: chat_attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(chat_partners_order_path(order.id))
      end
    end

    # TODO: 失敗パターンも実装
    context 'with invalid parameters' do
    end
  end
end
