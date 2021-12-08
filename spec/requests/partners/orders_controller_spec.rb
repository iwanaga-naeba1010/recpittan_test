# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::OrdersController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_custoemr }
  let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }

  before do
    sign_in partner
  end

  describe 'GET /show' do
    context 'with valid user' do
      it 'return http success' do
        get partners_order_path(order.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid user' do
      it 'return 302 when customer accessed' do
        sign_out partner
        sign_in customer
        get partners_order_path(order.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end

      it 'return 302 when user not logged in' do
        sign_out partner
        get partners_order_path(order.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /chat' do
    context 'with valid user' do
      it 'return http success' do
        get chat_partners_order_path(order.id)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid user' do
      it 'return 302 when customer accessed' do
        sign_out partner
        sign_in customer
        get chat_partners_order_path(order.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end

      it 'return 302 when user not logged in' do
        sign_out partner
        get chat_partners_order_path(order.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET /confirm' do
    context 'with valid user' do
      it 'returns http success' do
        get confirm_partners_order_path(order.id)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('partners/orders/confirm')
      end

      it 'renders accept template' do
        get confirm_partners_order_path(id: order.id, is_confirm: :accept)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('partners/orders/accept')
      end
      it 'renders accept template' do
        get confirm_partners_order_path(id: order.id, is_confirm: :deny)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template('partners/orders/deny')
      end
    end

    context 'with invalid user' do
      it 'return 302 when customer accessed' do
        sign_out partner
        sign_in customer
        get confirm_partners_order_path(order.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end

      it 'return 302 when user not logged in' do
        sign_out partner
        get confirm_partners_order_path(order.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PUT /update' do
    context 'when valid parameters' do
      it 'returns 302 status' do
        put partners_order_path(order.id), params: { order: { status: :facility_request_in_progress } }
        expect(response).to have_http_status(:found)
      end

      it 'update date_and_time' do
        order.update(date_and_time: Time.current)
        expect {
          put partners_order_path(order.id), params: { order: { date_and_time: '' } }
        }.to change { Order.find(order.id).date_and_time }.from(order.date_and_time).to(nil)
      end

      it 'update status' do
        expect {
          put partners_order_path(order.id), params: { order: { status: :facility_request_in_progress } }
        }.to change { Order.find(order.id).status }.from(order.status).to('facility_request_in_progress')
      end

      it 'update is_accepted' do
        expect {
          put partners_order_path(order.id), params: { order: { is_accepted: true } }
        }.to change { Order.find(order.id).is_accepted }.from(order.is_accepted).to(true)
      end

      it 'redirects to params[:redirect_path]' do
        put partners_order_path(id: order.id, redirect_path: chat_partners_order_path(order.id)), params: { order: { date_and_time: '' } }
        expect(response).to redirect_to chat_partners_order_path(order.id)
      end

      it 'uses params[:message]' do
        put partners_order_path(id: order.id, message: '修正'), params: { order: { date_and_time: '' } }
        expect(flash[:notice]).to eq '修正'
        # expect(response.body).should include('修正')
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

  describe 'GET /confirm' do
    context 'with valid user' do
      it 'returns http success' do
        get complete_partners_order_path(order.id)
        expect(response).to have_http_status(:ok)
        # expect(response).to render_template('partners/orders/confirm')
      end
    end

    context 'with invalid user' do
      it 'return 302 when customer accessed' do
        sign_out partner
        sign_in customer
        get complete_partners_order_path(order.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end

      it 'return 302 when user not logged in' do
        sign_out partner
        get complete_partners_order_path(order.id)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
