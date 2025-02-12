# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Invoices', type: :request do
  let(:admin_user) { create(:user, :with_admin) }
  let(:customer) { create(:user, :with_customer) }
  let(:company) { create(:company, user: customer) }
  let!(:order) { create(:order, user: customer, status: :finished, start_at: Time.zone.today) }

  before do
    sign_in admin_user # ActiveAdmin の認証を通す
  end

  describe 'POST /admin/invoices' do
    context '請求データが存在する場合' do
      it 'CSVをダウンロードできる' do
        post admin_invoices_path

        expect(response).to have_http_status(:success)
        expect(response.headers['Content-Type']).to include('text/csv')

        # Content-Disposition の filename を URLデコードして比較
        content_disposition = response.headers['Content-Disposition']
        decoded_filename = CGI.unescape(content_disposition.match(/filename\*?=UTF-8''(.+?)$/)[1])

        expect(decoded_filename).to eq('請求データ.csv')

        csv_lines = CSV.parse(response.body, headers: true)
        expect(csv_lines.first['件名']).to eq("#{Time.zone.now.month}月分レクリエーション費用")
        expect(csv_lines.first['施設名']).to eq(company.facility_name)
        expect(csv_lines.first['パートナー名']).to eq(order.recreation.user_username)
      end
    end

    context '請求データが存在しない場合' do
      before { Order.destroy_all } # 注文データを削除

      it '空のCSVをダウンロードする' do
        post admin_invoices_path

        expect(response).to have_http_status(:success)
        expect(response.headers['Content-Type']).to include('text/csv')

        csv_lines = CSV.parse(response.body, headers: true)
        expect(csv_lines.count).to eq(0) # データがないことを確認
      end
    end
  end
end
