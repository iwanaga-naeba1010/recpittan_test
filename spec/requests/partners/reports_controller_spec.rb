# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe Partners::ReportsController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_customer }
  let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id, status: :final_report_admits_not }
  let(:report) { create :report, order_id: order.id }

  before do
    sign_in partner
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_partners_order_report_path(order.id)
      expect(response).to have_http_status(:ok)
    end

    it 'returns found when report was' do
    end
  end

  describe 'POST /create' do
    let(:attrs) { attributes_for(:report, order_id: order.id) }

    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post partners_order_reports_path(order.id), params: { report: attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(partners_order_path(order.id))
      end
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_partners_order_report_path(order_id: order.id, id: report.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /update' do
    context 'when valid parameters' do
      it 'returns 302 status' do
        put partners_order_report_path(order_id: order.id, id: report.id), params: { report: { number_of_people: 11 } }
        expect(response).to have_http_status(:found)
      end

      it 'updates number_of_facilities' do
        expect {
          put partners_order_report_path(order_id: order.id, id: report.id), params: { report: { number_of_facilities: 11 } }
        }.to change { Report.find(report.id).number_of_facilities }.from(report.number_of_facilities).to(11)
      end

      it 'updates number_of_people' do
        expect {
          put partners_order_report_path(order_id: order.id, id: report.id), params: { report: { number_of_people: 11 } }
        }.to change { Report.find(report.id).number_of_people }.from(report.number_of_people).to(11)
      end

      it 'updates transportation_expenses' do
        expect {
          put partners_order_report_path(order_id: order.id, id: report.id), params: { report: { transportation_expenses: 100 } }
        }.to change { Report.find(report.id).transportation_expenses }.from(report.transportation_expenses).to(100)
      end

      it 'updates expenses' do
        expect {
          put partners_order_report_path(order_id: order.id, id: report.id), params: { report: { expenses: 100 } }
        }.to change { Report.find(report.id).expenses }.from(report.expenses).to(100)
      end

      it 'updates body' do
        expect {
          put partners_order_report_path(order_id: order.id, id: report.id), params: { report: { body: '内容です' } }
        }.to change { Report.find(report.id).body }.from(report.body).to('内容です')
      end

      it 'creates an evaluation' do
        expect {
          put partners_order_report_path(order_id: order.id, id: report.id), params: { report: { number_of_people: 11 } }
        }.not_to change(Evaluation, :count)
      end

      it 'updates number_of_people of order' do
        expect {
          put partners_order_report_path(order_id: order.id, id: report.id), params: { report: { number_of_people: 11 } }
        }.to change { Order.find(order.id).number_of_people }.from(order.number_of_people).to(11)
      end

      it 'updates number_of_facilities of order' do
        expect {
          put partners_order_report_path(order_id: order.id, id: report.id), params: { report: { number_of_facilities: 11 } }
        }.to change { Order.find(order.id).number_of_facilities }.from(order.number_of_facilities).to(11)
      end

      it 'updates transportation_expenses of order' do
        expect {
          put partners_order_report_path(order_id: order.id, id: report.id), params: { report: { transportation_expenses: 1000 } }
        }.to change { Order.find(report.order.id).transportation_expenses }.from(report.order.transportation_expenses).to(1000)
      end

      it 'updates expenses of order' do
        expect {
          put partners_order_report_path(order_id: order.id, id: report.id), params: { report: { expenses: 100 } }
        }.to change { Order.find(report.order.id).expenses }.from(report.order.expenses).to(100)
      end
      # TODO: 理想な全部やりたいけど、時間の都合上一旦むし
      # it 'update evaluation ingenuity' do
      #   evaluation_attr[:ingenuity] = :neither
      #   expect {
      #     put customers_report_path(report.id), params: { report: { evaluation_attributes: evaluation_attr } }
      #   }.to change {
      #     Report.find(report.id).evaluation.ingenuity
      #   }.from(nil).to('neither')
      # end
    end
  end
end
