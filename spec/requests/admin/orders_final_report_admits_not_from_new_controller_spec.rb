# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders::FinalReportAdmitsNotFromNew', type: :request do
  let(:admin) { create :user, :with_admin }
  let(:customer) { create :user, :with_custoemr }
  let(:partner) { create :user, :with_recreations }
  let!(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'return http success' do
      get admin_orders_final_report_admits_not_from_news_index_path
      expect(response).to have_http_status(:ok)
    end
  end

  # TODO(okubo): postするpathが間違っているっぽいので、後で直す
  # describe 'POST #create' do
  #   let(:attrs) { attributes_for(
  #     :order,
  #     recreation_id: partner.recreations.first.id,
  #     user_id: customer.id,
  #     start_at: Date.yesterday,
  #     end_at: Date.yesterday
  #   ) }
  #
  #   context 'with valid parameters' do
  #     it 'return http success when user not logged in' do
  #       post admin_orders_final_report_admits_not_from_news_index_path, params: { orders_force_waiting_for_an_event_to_take_place_from_new: attrs }
  #       expect(response).to have_http_status(:found)
  #       expect(response).to redirect_to(admin_order_path(FinalReportAdmitsNotFromNew.last.id))
  #     end
  #
  #     it 'can create user_company and increase one record' do
  #       expect {
  #         post admin_orders_final_report_admits_not_from_news_index_path, params: { orders_force_waiting_for_an_event_to_take_place_from_new: attrs }
  #       }.to change(Order, :count).by(+1)
  #     end
  #   end
  #
  #   # TODO: 失敗パターンも実装
  #   context 'with invalid parameters' do
  #   end
  # end

  describe 'GET #new' do
    it 'return http success' do
      get new_admin_orders_final_report_admits_not_from_news_path
      expect(response).to have_http_status(:ok)
    end
  end

end
