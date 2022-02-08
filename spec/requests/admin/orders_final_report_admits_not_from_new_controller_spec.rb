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
      get admin_orders_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    # TODO(okubo): ここにstart_atなど必要なデータ入れる
    # TODO(okubo): その後にstatusが変わることを検証
    let(:attrs) { attributes_for(
      :order,
      recreation_id: partner.recreations.first.id,
      user_id: customer.id,
      start_at: Date.yesterday,
      end_at: Date.yesterday,
    ) }

    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post admin_orders_path, params: { order: attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(admin_order_path(Order.last.id))
      end

      it 'can create user_company and increase one record' do
        expect {
          post admin_orders_path, params: { order: attrs }
        }.to change(Order, :count).by(+1)
      end
    end

    # TODO: 失敗パターンも実装
    context 'with invalid parameters' do
    end
  end

  describe 'GET #new' do
    it 'return http success' do
      get new_admin_orders_final_report_admits_not_from_news_path
      expect(response).to have_http_status(:ok)
    end
  end

end
