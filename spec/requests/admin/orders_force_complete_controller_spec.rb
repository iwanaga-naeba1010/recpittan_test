# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OrdersForceComplete', type: :request do
  let(:admin) { create :user, :with_admin }
  let(:customer) { create :user, :with_customer }
  let(:partner) { create :user, :with_recreations }
  let!(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id, status: :unreported_completed }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'return http success' do
      get admin_orders_force_completes_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'return http success' do
      get admin_orders_force_complete_path(order.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #edit' do
    it 'return http success' do
      get edit_admin_orders_force_complete_path(order.id)
      expect(response).to have_http_status(:ok)
    end
  end

  # TODO: 変更する内容は考えた方が良いかも。良いテストではない
  describe 'PUT #update' do
    context 'when valid parameters' do
      number_of_people = 10
      it 'returns 302 status' do
        put admin_orders_force_complete_path(order.id), params: { order: { number_of_people: number_of_people } }
        expect(response).to have_http_status(:found)
      end

      it 'updates unreported_completed to finished' do
        expect {
          put admin_orders_force_complete_path(order.id), params: { order: { number_of_people: number_of_people } }
        }.to change { Order.find(order.id).status }.from('unreported_completed').to('finished')
      end

      it 'increases a report' do
        expect {
          put admin_orders_force_complete_path(order.id), params: { order: { number_of_people: number_of_people } }
        }.to change(Report, :count).by(+1)
      end

      it 'increases a evaluation' do
        expect {
          put admin_orders_force_complete_path(order.id), params: { order: { number_of_people: number_of_people } }
        }.to change(Evaluation, :count).by(+1)
      end
    end
  end
end
