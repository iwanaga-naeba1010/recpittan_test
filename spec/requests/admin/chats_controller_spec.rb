# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Chats', type: :request do
  include_context 'with authenticated admin'

  describe 'POST /admin/orders/:order_id/chats' do
    let!(:partner) { create(:user, :with_partner) }
    let!(:customer) { create(:user, :with_customer) }
    let!(:order) { create(:order, user: customer, recreation: partner.recreations.first) }
    let(:params) { { chat: attributes_for(:chat, user: current_user, order: order) } }
    let(:order_id) { order.id }
    let(:expected_redirect_to) { %r{/admin/orders/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end
end
