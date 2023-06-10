# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe Partners::OrdersController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_customer }
  let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }
  let(:report) { create :report, order_id: order.id }
  let(:evaluation) { create :evaluation, report_id: report.id }

  before do
    sign_in partner
  end

  describe 'GET /partners/recreations/:id/evaluations' do
    let!(:recreation) { create(:recreation, user: partner) }
    let(:id) { recreation.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /show' do
    context 'with valid user' do
      it 'return http success' do
        get partners_order_evaluation_path(order_id: order.id, id: evaluation.id)
        expect(response).to have_http_status(:ok)
      end
      it 'renders show page when partner not accepted' do
        get partners_order_evaluation_path(order_id: order.id, id: evaluation.id)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('partners/evaluations/show')
      end
    end

    context 'with invalid user' do
      it 'return 302 when customer accessed' do
        sign_out partner
        sign_in customer
        get partners_order_evaluation_path(order_id: order.id, id: evaluation.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end

      it 'return 302 when user not logged in' do
        sign_out partner
        get partners_order_evaluation_path(order_id: order.id, id: evaluation.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
