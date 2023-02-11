# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiCustomer::Orders::ChatsController, type: :request do
  include_context 'with authenticated customer'
  let!(:partner) { create(:user, :with_partner) }
  let!(:order) { create(:order, user: current_user, recreation: partner.recreations.first) }

  describe 'GET /api_customer/orders/:order_id/chats' do
    let!(:chats) { create_list(:chat, 5, user: current_user, order:) }
    let(:order_id) { order.id }
    let(:expected) { ChatSerializer.new.serialize_list(chats:) }

    it_behaves_like 'an endpoint returns', :expected
  end

  describe 'POST /api_customer/orders/:order_id/chats' do
    let!(:chat) { create(:chat, user: current_user, order:) }
    let(:order_id) { order.id }
    let(:params) do
      {
        chat: attributes_for(
          :chat,
          user: current_user,
          order:
        )
      }
    end
    let(:expected) { ChatSerializer.new.serialize(chat: Chat.last) }

    it_behaves_like 'an endpoint returns 2xx status', :expected

    context 'with valid params' do
      it_behaves_like 'an endpoint returns', :expected
    end

    context 'with invalid params' do
      let(:params) { { chat: { message: '' } } }
      it_behaves_like 'an endpoint returns 4xx status'
    end
  end
end
