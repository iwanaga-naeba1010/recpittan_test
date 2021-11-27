# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OrderMemos', type: :request do
  let(:admin) { create :user, :with_admin }
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_custoemr }
  let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }

  before do
    sign_in admin
  end

  describe 'POST #create' do
    let(:attrs) { attributes_for(:order_memo, order_id: order.id) }

    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post admin_order_memos_path, params: { order_memo: attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(admin_order_path(order.id))
      end

      it 'can create order memo and increase one record' do
        expect {
          post admin_order_memos_path, params: { order_memo: attrs }
        }.to change(OrderMemo, :count).by(+1)
      end
    end

    # TODO: 失敗パターンも実装
    context 'with invalid parameters' do
    end
  end
end
