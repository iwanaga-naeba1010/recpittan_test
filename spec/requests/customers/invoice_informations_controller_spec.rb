# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe Customers::InvoiceInformationsController, type: :request do
  include_context 'with authenticated customer'

  let(:customer) { current_user }

  describe 'GET /customers/invoice_informations/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /customers/invoice_informations/:id/edit' do
    let!(:invoice_information) { create(:invoice_information, user_id: customer.id) }
    let!(:id) { invoice_information.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /customers/invoice_informations' do
    let(:params) do
      { invoice_information: attributes_for(:invoice_information, user_id: customer.id) }
    end
    let(:expected_redirect_to) { %r{/customers/invoice_informations/[0-9]+/edit} }

    it_behaves_like 'an endpoint redirects match'

    context 'with invalid params' do
      let(:params) { { invoice_information: { name: '' } } }

      it_behaves_like 'an endpoint returns 2xx status'
    end
  end

  describe 'PATCH /customers/invoice_informations/:id' do
    let!(:invoice_information) { create(:invoice_information, user_id: customer.id) }
    let!(:id) { invoice_information.id }
    let(:params) do
      { invoice_information: attributes_for(:invoice_information, user_id: customer.id) }
    end
    let(:expected_redirect_to) { %r{/customers/invoice_informations/[0-9]+/edit} }

    it_behaves_like 'an endpoint redirects match'

    context 'with invalid params' do
      let(:params) { { invoice_information: { name: '' } } }

      it_behaves_like 'an endpoint returns 2xx status'
    end
  end
end
