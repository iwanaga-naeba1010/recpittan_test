# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tags', type: :request do
  let(:admin) { create :user, :with_admin }
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_custoemr }
  let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }

  before do
    sign_in admin
  end

  describe 'POST #create' do
    let(:attrs) { attributes_for(:chat, user_id: admin.id, order_id: order.id) }

    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post admin_chats_path, params: { chat: attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(admin_order_path(order.id))
      end

      it 'can create user_company and increase one record' do
        expect {
          post admin_tags_path, params: { tag: attrs }
        }.to change(Tag, :count).by(+1)
      end
    end

    # TODO: 失敗パターンも実装
    context 'with invalid parameters' do
    end
  end
end
