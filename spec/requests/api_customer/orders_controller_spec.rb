# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiCustomer::OrdersController, type: :request do
  include_context 'with authenticated customer'
  let!(:partner) { create(:user, :with_partner) }

  describe 'GET /api_customer/orders/:id' do
    let!(:order) { create(:order, user: current_user, recreation: partner.recreations.first) }
    let(:id) { order.id }
    let(:expected) { OrderSerializer.new.serialize(order: order) }

    it_behaves_like 'an endpoint returns', :expected
  end

  describe 'PATCH /api_customer/orders/:id' do
    let!(:order) { create(:order, user: current_user, recreation: partner.recreations.first) }
    let(:id) { order.id }
    let(:expected) { OrderSerializer.new.serialize(order: order) }

    let!(:params) { { order: attributes_for(:order, user: current_user) } }
    let(:expected) { OrderSerializer.new.serialize(order: order) }

    it_behaves_like 'an endpoint returns', :expected

    context 'with valid params' do
      it_behaves_like 'an endpoint returns 2xx status'
    end

    context 'with invalid params' do
      let!(:params) { { recreation: { user_id: 0 } } }
      it_behaves_like 'an endpoint returns 4xx status', :expected
    end
  end
end
