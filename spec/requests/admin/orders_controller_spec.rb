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

      it 'can create chat and increase one record' do
        expect {
          post admin_orders_path, params: { order: attrs }
        }.to change(Chat, :count).by(+1)
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
      number_of_people = 10
      it 'returns 302 status' do
        put admin_order_path(order.id), params: { order: { number_of_people: number_of_people } }
        expect(response).to have_http_status(:found)
      end

      it 'update status' do
        expect {
          put admin_order_path(order.id), params: { order: { number_of_people: number_of_people } }
        }.to change { Order.find(order.id).number_of_people }.from(order.number_of_people).to(number_of_people)
      end

      it 'updates costs' do
        attrs = attributes_for(:order, regular_price: 1000, regular_material_price: 1000, instructor_amount: 1000, instructor_material_amount: 1000)
        put admin_order_path(order.id), params: { order: attrs }
        order.reload
        expect(order.regular_price).to be attrs[:regular_price]
        expect(order.regular_material_price).to be attrs[:regular_material_price]
        expect(order.instructor_amount).to be attrs[:instructor_amount]
        expect(order.instructor_material_amount).to be attrs[:instructor_material_amount]
      end

      # TODO(okubo): 理想は全てのpatternを入れたい
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
