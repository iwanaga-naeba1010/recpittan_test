# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe Customers::OrdersController, type: :request do
  let(:user) { create :user, :with_custoemr }
  let(:partner) { create :user, :with_recreations }
  let(:recreation) { partner.recreations.first }
  let(:order) { create :order, :with_order_dates, recreation_id: recreation.id, user_id: user.id }

  before do
    sign_in user
  end

  before :all do
    Rails.application.load_tasks
    Rake::Task['import:email_templates'].invoke
  end

  # NOTE: 事前にEmailTemplateを用意する必要あるため、設定
  describe 'GET /new' do
    context 'with valid user' do
      it 'return http success' do
        get new_customers_recreation_order_path(recreation)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid user' do
      it 'return http success when user not logged in' do
        sign_out user
        get new_customers_recreation_order_path(recreation)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # TODO: テスト書きたいが、エラー出て時間かかりそうなので一旦スルー
  describe 'POST /create' do
    let(:order_attrs) { attributes_for(:order, recreation_id: recreation.id, user_id: user.id,
      order_dates_attributes: [
        { year: 2022, month: 1, date: 1, start_hour: 13, start_minute: 30, end_hour: 14, end_minute: 30 },
        { year: 2022, month: 1, date: 2, start_hour: 13, start_minute: 30, end_hour: 14, end_minute: 30 },
        { year: 2022, month: 1, date: 3, start_hour: 13, start_minute: 30, end_hour: 14, end_minute: 30 }
      ])
    }

    context 'with valid parameters' do
      # TODO: 正式リリースのタイミングでこちらに戻す
      it 'return http success when user not logged in' do
        post customers_recreation_orders_path(recreation), params: { order: order_attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(chat_customers_order_path(Order.last.id))
      end
      # it 'return http success when user not logged in' do
      #   post customers_recreation_orders_path(recreation), params: { order: order_attrs }
      #   expect(response.status).to eq 200
      #   expect(response.parsed_body['id']).not_to be nil
      #   # expect(response).to redirect_to(chat_customers_order_path(Order.last.id))
      # end
    end

    # it 'return http success when user not logged in' do
    #   get customers_recreation_path(recreation)
    #   expect(response).to have_http_status(:ok)
    # end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get customers_order_path(order)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /chat' do
    it 'returns http success' do
      get chat_customers_order_path(order)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /complete' do
    context 'with valid order status' do
      it 'returns http success' do
        order.update(start_at: Time.current)
        get complete_customers_order_path(order)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid order status' do
      it 'redirects to chat path' do
        get complete_customers_order_path(order)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to chat_customers_order_path(order)
      end
    end
  end

  describe 'PUT /update' do
    context 'when valid parameters' do
      params = {
        status: :waiting_for_a_reply_from_partner, dates: { '0' => { year: '2022', month: '1', date: '1', start_hour: '09', start_minutes: '00', end_hour: '10', end_minutes: '00' } },
        number_of_people: 11, zip: '4536111', prefecture: '愛知県', city: '名古屋市中村区', street: '平池町グローバルゲート　１１階', building: 'building'
      }
      it 'returns 302 status' do
        put customers_order_path(order.id), params: { order: params }
        expect(response).to have_http_status(:found)
      end

      it 'update start_at' do
        date = Time.new(
          order.order_dates[0].year,
          order.order_dates[0].month,
          order.order_dates[0].date,
          order.order_dates[0].start_hour,
          order.order_dates[0].start_minute,
        )

        expect {
          put customers_order_path(order.id), params: { order: params }
        }.to change { Order.find(order.id).start_at }.from(order.start_at).to(date)
      end

      it 'update number_of_people' do
        expect {
          put customers_order_path(order.id), params: { order: params }
        }.to change { Order.find(order.id).number_of_people }.from(order.number_of_people).to(params[:number_of_people])
      end
      it 'update zip' do
        expect {
          put customers_order_path(order.id), params: { order: params }
        }.to change { Order.find(order.id).zip }.from(order.zip).to(params[:zip])
      end
      it 'update prefecture' do
        expect {
          put customers_order_path(order.id), params: { order: params }
        }.to change { Order.find(order.id).prefecture }.from(order.prefecture).to(params[:prefecture])
      end
      it 'update city' do
        expect {
          put customers_order_path(order.id), params: { order: params }
        }.to change { Order.find(order.id).city }.from(order.city).to(params[:city])
      end
      it 'update street' do
        expect {
          put customers_order_path(order.id), params: { order: params }
        }.to change { Order.find(order.id).street }.from(order.street).to(params[:street])
      end
      it 'update building' do
        expect {
          put customers_order_path(order.id), params: { order: params }
        }.to change { Order.find(order.id).building }.from(order.building).to(params[:building])
      end
    end

    # TODO: 後々実装
    context 'with invalid right' do
      # it 'redirects to root path when role is read' do
      #   put managers_billboard_path(billboard.id), params: { billboard: { title: 'billbaordtitle' } }
      #   expect(response).to have_http_status(:found)
      #   expect(response).to redirect_to users_path
      # end
    end
  end
end
