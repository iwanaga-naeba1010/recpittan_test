# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe Partners::ReportsController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_customer }
  let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id, status: :final_report_admits_not }
  let(:zoom) { create :zoom, order_id: order.id }

  before do
    sign_in partner
    Rails.application.load_tasks
    Rake::Task['import:email_templates'].invoke
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_partners_order_zoom_path(order.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /create' do
    let(:attrs) { attributes_for(:zoom, order_id: order.id) }

    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post partners_order_zooms_path(order.id), params: { zoom: attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(partners_order_path(order.id))
      end
    end
  end

  describe 'GET /edit' do
    it 'redirects to order with created by admin' do
      zoom.update(created_by: :admin)

      get edit_partners_order_zoom_path(order_id: order.id, id: zoom.id)
      expect(response).to redirect_to partners_order_path(order.id)
      expect(flash[:alert]).to match(/権限がありません/)
    end

    it 'returns http success' do
      get edit_partners_order_zoom_path(order_id: order.id, id: zoom.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /update' do
    let(:attrs) { attributes_for(:zoom) }
    context 'when valid parameters' do
      it 'redirects to order with created by admin' do
        zoom.update(created_by: :admin)

        get edit_partners_order_zoom_path(order_id: order.id, id: zoom.id)
        expect(response).to redirect_to partners_order_path(order.id)
        expect(flash[:alert]).to match(/権限がありません/)
      end

      it 'returns 302 status' do
        put partners_order_zoom_path(order_id: order.id, id: zoom.id), params: { zoom: attrs }
        expect(response).to have_http_status(:found)
      end

      it 'updates url' do
        url = 'https://testtesttest.com'
        expect {
          put partners_order_zoom_path(order_id: order.id, id: zoom.id), params: { zoom: { url: url } }
        }.to change { Zoom.find(zoom.id).url }.from(zoom.url).to(url)
      end

      it 'updates price' do
        price = 0
        expect {
          put partners_order_zoom_path(order_id: order.id, id: zoom.id), params: { zoom: { price: price } }
        }.to change { Zoom.find(zoom.id).price }.from(zoom.price).to(price)
      end
    end
  end
end
