# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe Customers::ReportsController, type: :request do
  let(:user) { create :user, :with_custoemr }
  let(:partner) { create :user, :with_recreations }
  let(:recreation) { partner.recreations.first }
  let(:order) { create :order, recreation_id: recreation.id, user_id: user.id }
  let(:report) { create :report, order_id: order.id }

  before do
    sign_in user
  end

  before :all do
    Rails.application.load_tasks
    Rake::Task['import:email_templates'].invoke
  end

  describe 'GET /edit' do
    context 'with valid user' do
      it 'return http success' do
        get edit_customers_report_path(report)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid user' do
      it 'return http success when user not logged in' do
        sign_out user
        get edit_customers_report_path(report)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PUT /update' do
    context 'when valid parameters' do
      let(:attr) { attributes_for :report, order_id: order.id }
      let(:evaluation_attr) { attributes_for :evaluation, report_id: report.id }

      it 'returns 302 status' do
        put customers_report_path(report.id), params: { report: attr }
        expect(response).to have_http_status(:found)
      end

      it 'update status' do
        expect {
          put customers_report_path(report.id), params: { report: { status: :denied } }
        }.to change { Report.find(report.id).status }.from(report.status).to('denied')
      end

      it 'creates an evaluation' do
        expect {
          put customers_report_path(report.id), params: { report: { evaluation_attributes: evaluation_attr } }
        }.to change(Evaluation, :count).by(+1)
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
