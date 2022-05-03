# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OrdersWaitingForAnEventToTakePlaceToInProgress', type: :request do
  let(:admin) { create :user, :with_admin }
  let(:customer) { create :user, :with_customer }
  let(:partner) { create :user, :with_recreations }
  let!(:order) do
    create(
      :order,
      recreation_id: partner.recreations.first.id,
      user_id: customer.id,
      start_at: DateTime.tomorrow,
      end_at: DateTime.tomorrow,
      is_accepted: true
    )
  end

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'return http success' do
      get admin_orders_waiting_for_an_event_to_take_place_to_in_progresses_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #edit' do
    it 'return http success' do
      get edit_admin_orders_waiting_for_an_event_to_take_place_to_in_progress_path(order.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update' do
    context 'when valid parameters' do
      it 'returns 302 status' do
        put admin_orders_waiting_for_an_event_to_take_place_to_in_progress_path(order.id), params: { orders_waiting_for_an_event_to_take_place_to_in_progress: {} }
        expect(response).to have_http_status(:found)
      end

      it 'updates in_progress to waiting_for_an_event_to_take_place' do
        expect {
          put admin_orders_waiting_for_an_event_to_take_place_to_in_progress_path(order.id), params: { orders_waiting_for_an_event_to_take_place_to_in_progress: {} }
          order.reload
        }.to change { Order.find(order.id).status }.from('waiting_for_an_event_to_take_place').to('in_progress')
      end

      it 'makes start_at nil' do
        expect {
          put admin_orders_waiting_for_an_event_to_take_place_to_in_progress_path(order.id), params: { orders_waiting_for_an_event_to_take_place_to_in_progress: {} }
          order.reload
        }.to change { Order.find(order.id).start_at }.from(order.start_at).to(nil)
      end

      it 'makes end_at nil' do
        expect {
          put admin_orders_waiting_for_an_event_to_take_place_to_in_progress_path(order.id), params: { orders_waiting_for_an_event_to_take_place_to_in_progress: {} }
          order.reload
        }.to change { Order.find(order.id).end_at }.from(order.end_at).to(nil)
      end

      it 'updates is accepted' do
        expect {
          put admin_orders_waiting_for_an_event_to_take_place_to_in_progress_path(order.id), params: { orders_waiting_for_an_event_to_take_place_to_in_progress: {} }
          order.reload
        }.to change { Order.find(order.id).is_accepted }.from(true).to(false)
      end
    end
  end
end
