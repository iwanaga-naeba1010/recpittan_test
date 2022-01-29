# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OrdersForceWaitingForAnEventToTakePlace', type: :request do
  let(:admin) { create :user, :with_admin }
  let(:customer) { create :user, :with_custoemr }
  let(:partner) { create :user, :with_recreations }
  let!(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id, status: :in_progress }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'return http success' do
      get admin_orders_force_waiting_for_an_event_to_take_places_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'return http success' do
      get admin_orders_force_waiting_for_an_event_to_take_place_path(order.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #edit' do
    it 'return http success' do
      get edit_admin_orders_force_waiting_for_an_event_to_take_place_path(order.id)
      expect(response).to have_http_status(:ok)
    end
  end

  # TODO: 変更する内容は考えた方が良いかも。良いテストではない
  describe 'PUT #update' do
    context 'when valid parameters' do
      # NOTE(okubo): 時間をそのまま比較すると秒以下の誤差が生じるので日付と時間で比較
      start_at = DateTime.now

      it 'returns 302 status' do
        put admin_orders_force_waiting_for_an_event_to_take_place_path(order.id), params: { orders_force_waiting_for_an_event_to_take_place: { start_at: start_at } }
        expect(response).to have_http_status(:found)
      end

      it 'updates in_progress to waiting_for_an_event_to_take_place' do
        expect {
          put admin_orders_force_waiting_for_an_event_to_take_place_path(order.id), params: { orders_force_waiting_for_an_event_to_take_place: { start_at: start_at } }
        }.to change { Order.find(order.id).start_at&.strftime('%Y.%m.%d %H:%M') }.from(nil).to(start_at&.strftime('%Y.%m.%d %H:%M'))
      end

      it 'updates is accepted' do
        expect {
          put admin_orders_force_waiting_for_an_event_to_take_place_path(order.id), params: { orders_force_waiting_for_an_event_to_take_place: { start_at: start_at } }
        }.to change { Order.find(order.id).is_accepted }.from(false).to(true)
      end
    end
  end

end
