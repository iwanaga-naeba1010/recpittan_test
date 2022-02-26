# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :request do
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

  describe 'GET #show' do
    it 'return http success' do
      get admin_order_path(order.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    let(:attrs) { attributes_for(:order, recreation_id: partner.recreations.first.id, user_id: customer.id) }

    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post admin_orders_path, params: { order: attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(admin_order_path(Order.last.id))
      end

      it 'can create order and increase one record' do
        expect {
          post admin_orders_path, params: { order: attrs }
        }.to change(Order, :count).by(+1)
      end

      it 'can create order_date and increase one record' do
        expect {
          post admin_orders_path, params: { order: attrs }
        }.to change(OrderDate, :count).by(+1)
      end
    end

    # TODO: 失敗パターンも実装
    context 'with invalid parameters' do
    end
  end

  describe 'GET #edit' do
    it 'return http success' do
      get edit_admin_order_path(order.id)
      expect(response).to have_http_status(:ok)
    end
  end

  # TODO: 変更する内容は考えた方が良いかも。良いテストではない
  describe 'PUT #update' do
    context 'when valid parameters' do
      attrs = {
        zip: '4536111',
        prefecture: '愛知県',
        city: '名古屋市',
        street: '中村区平池町4丁目60番地の12 ',
        building: 'グローバルゲート11階',
        number_of_people: 2,
        number_of_facilities: 2,
        # start_at: Time.zone.tomorrow,
        # end_at: Time.zone.tomorrow,
        regular_price: 50000,
        regular_material_price: 10000,
        instructor_amount: 30000,
        instructor_material_amount: 5000,
        additional_facility_fee: 5000,
        expenses: 10000,
        transportation_expenses: 10000,
        support_price: 10000,
        zoom_price: 500
      }

      it 'updates order when staus is less than 40' do
        put admin_order_path(order.id), params: { order: attrs }
        order.reload
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to admin_order_path(order.id)

        expect(order.regular_price).to eq attrs[:regular_price]
        expect(order.regular_material_price).to eq attrs[:regular_material_price]
        expect(order.instructor_amount).to eq attrs[:instructor_amount]
        expect(order.instructor_material_amount).to eq attrs[:instructor_material_amount]
        expect(order.additional_facility_fee).to eq attrs[:additional_facility_fee]
        expect(order.expenses).to eq attrs[:expenses]
        expect(order.transportation_expenses).to eq attrs[:transportation_expenses]
        expect(order.support_price).to eq attrs[:support_price]
        expect(order.zoom_price).to eq attrs[:zoom_price]
      end

      # NOTE(okubo): 200以上の完了系ステータスが機能すること
      it 'updates order when status is more than 200' do
        order = create(:order, :with_finished, recreation_id: partner.recreations.first.id, user_id: customer.id)
        attrs[:report_attributes] = order.report.attributes
        attrs[:evaluation] = order.report.evaluation.attributes

        put admin_order_path(order.id), params: { order: attrs }
        order.reload

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to admin_order_path(order.id)
        # expect(order.status).to eq attrs[:status]
        expect(order.zip).to eq attrs[:zip]
        expect(order.prefecture).to eq attrs[:prefecture]
        expect(order.city).to eq attrs[:city]
        expect(order.street).to eq attrs[:street]
        expect(order.building).to eq attrs[:building]
        expect(order.number_of_people).to eq attrs[:number_of_people]
        expect(order.number_of_facilities).to eq attrs[:number_of_facilities]
        # TODO(okubo): 時間完全一致のテスト修正してください。若干ずれる
        # expect(order.start_at).to eq attrs[:start_at]
        # expect(order.end_at).to eq attrs[:end_at]

        expect(order.regular_price).to eq attrs[:regular_price]
        expect(order.regular_material_price).to eq attrs[:regular_material_price]
        expect(order.instructor_amount).to eq attrs[:instructor_amount]
        expect(order.instructor_material_amount).to eq attrs[:instructor_material_amount]
        expect(order.additional_facility_fee).to eq attrs[:additional_facility_fee]
        expect(order.expenses).to eq attrs[:expenses]
        expect(order.transportation_expenses).to eq attrs[:transportation_expenses]
        expect(order.support_price).to eq attrs[:support_price]
        expect(order.zoom_price).to eq attrs[:zoom_price]
      end

      # NOTE(okubo): 70以上、かつ、評価が入力されている場合
      it 'updates order when status is more than 70 and evaluation is present' do
        order = create(:order, :with_final_report_admits_not, recreation_id: partner.recreations.first.id, user_id: customer.id)
        order.report.status = :accepted
        attrs[:report_attributes] = order.report.attributes
        evaluation = attributes_for(:evaluation, report_id: order.report.id)
        attrs[:evaluation] = evaluation

        put admin_order_path(order.id), params: { order: attrs }
        order.reload

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to admin_order_path(order.id)
        expect(order.status).to eq 'finished'
        expect(order.zip).to eq attrs[:zip]
        expect(order.prefecture).to eq attrs[:prefecture]
        expect(order.city).to eq attrs[:city]
        expect(order.street).to eq attrs[:street]
        expect(order.building).to eq attrs[:building]
        expect(order.number_of_people).to eq attrs[:number_of_people]
        expect(order.number_of_facilities).to eq attrs[:number_of_facilities]
        # TODO(okubo): 時間完全一致のテスト修正してください。若干ずれる
        # expect(order.start_at).to eq attrs[:start_at]
        # expect(order.end_at).to eq attrs[:end_at]

        expect(order.regular_price).to eq attrs[:regular_price]
        expect(order.regular_material_price).to eq attrs[:regular_material_price]
        expect(order.instructor_amount).to eq attrs[:instructor_amount]
        expect(order.instructor_material_amount).to eq attrs[:instructor_material_amount]
        expect(order.additional_facility_fee).to eq attrs[:additional_facility_fee]
        expect(order.expenses).to eq attrs[:expenses]
        expect(order.transportation_expenses).to eq attrs[:transportation_expenses]
        expect(order.support_price).to eq attrs[:support_price]
        expect(order.zoom_price).to eq attrs[:zoom_price]
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'success' do
      it 'reduce one record' do
        expect { delete admin_order_path(order.id) }.to change(Order, :count).by(-1)
      end

      it 'redirects to orders  path' do
        delete admin_order_path(order.id)
        expect(response).to redirect_to admin_orders_path
      end
    end
  end
end
