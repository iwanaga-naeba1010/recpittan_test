# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::OrdersController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_custoemr }
  let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }

  before do
    sign_in partner
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_partners_order_report_path(order.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    let(:attrs) { attributes_for(:report, order_id: order.id) }

    context 'with valid parameters' do
      # TODO: 正式リリースのタイミングでこちらに戻す
      it 'return http success when user not logged in' do
        post partners_order_reports_path(order.id), params: { report: attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(partners_order_path(order.id))
      end
      # it 'return http success when user not logged in' do
      #   post customers_recreation_orders_path(recreation), params: { order: order_attrs }
      #   expect(response.status).to eq 200
      #   # binding.pry
      #   expect(response.parsed_body['id']).not_to be nil
      #   # expect(response).to redirect_to(chat_customers_order_path(Order.last.id))
      # end
    end

    # it 'return http success when user not logged in' do
    #   get customers_recreation_path(recreation)
    #   expect(response).to have_http_status(:ok)
    # end
  end
end
