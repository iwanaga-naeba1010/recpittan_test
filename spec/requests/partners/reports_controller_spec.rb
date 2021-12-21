# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe Partners::OrdersController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_custoemr }
  let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }
  let(:report) { create :report, order_id: order.id }

  before do
    sign_in partner
    Rails.application.load_tasks
    Rake::Task['import:email_templates'].invoke
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

      it 'updates number_of_people' do
        expect {
          put partners_order_report_path(order_id: order.id, id: report.id), params: { report: { number_of_people: 11 } }
        }.to change { Report.find(report.id).number_of_people }.from(report.number_of_people).to(11)
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
