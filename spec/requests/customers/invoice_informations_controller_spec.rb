# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe Customers::InvoiceInformationsController, type: :request do
  let(:user) { create :user, :with_customer }
  let(:invoice_information) { create :invoice_information, user_id: user.id }

  before do
    sign_in user
  end

  describe 'GET /new' do
    context 'with valid user' do
      it 'return http success' do
        get new_customers_invoice_information_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid user' do
      it 'return http success when user not logged in' do
        sign_out user
        get new_customers_invoice_information_path
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST /create' do
    let(:invoice_information_attrs) { attributes_for(:invoice_information) }

    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post customers_invoice_informations_path, params: { invoice_information: invoice_information_attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(customers_path)
      end
    end
  end

  describe 'GET /edit' do
    context 'with valid user' do
      it 'return http success' do
        get edit_customers_invoice_information_path(invoice_information)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid user' do
      it 'return http success when user not logged in' do
        sign_out user
        get edit_customers_invoice_information_path(invoice_information)
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PUT /update' do
    context 'when valid parameters' do
      let(:attr) { attributes_for :invoice_information }

      it 'returns 302 status' do
        put customers_invoice_information_path(invoice_information), params: { invoice_information: attr }
        expect(response).to have_http_status(:found)
      end

      it 'update name' do
        expect {
          put customers_invoice_information_path(invoice_information), params: { invoice_information: { name: 'changed_name' } }
        }.to change { InvoiceInformation.find(invoice_information.id).name }.from(invoice_information.name).to('changed_name')
      end
    end
  end
end
