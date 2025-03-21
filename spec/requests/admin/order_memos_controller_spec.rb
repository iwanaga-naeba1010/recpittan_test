# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OrderMemos', type: :request do
  include_context 'with authenticated admin'

  describe 'POST /admin/orders/:order_id/order_memos' do
    let!(:partner) { create(:user, :with_partner) }
    let!(:customer) { create(:user, :with_customer) }
    let!(:order) { create(:order, user: customer, recreation: partner.recreations.first) }
    let(:params) { { chat: attributes_for(:chat, user: current_user, order:) } }
    let(:order_id) { order.id }
    let(:expected_redirect_to) { %r{/admin/orders/[0-9]+} }
    let(:params) { { order_memo: attributes_for(:order_memo, order:) } }

    it_behaves_like 'an endpoint redirects match'
  end
end
