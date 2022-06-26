# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'InvoiceInformaitons', type: :request do
  include_context 'with authenticated admin'
  let(:admin) { create :user, :with_admin }
  let(:customer) { create :user, :with_customer }
  let!(:invoice_information) { create :invoice_information, user_id: customer.id }

  describe 'GET /admin/invoice_informations' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/invoice_informations/:id' do
    let!(:id) { invoice_information.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/invoice_informations/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/invoice_informations/:id/edit' do
    let!(:id) { invoice_information.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/invoice_informations' do
    let!(:customer) { create(:user, :with_customer) }
    let(:params) { { invoice_information: attributes_for(:invoice_information, user_id: customer.id) } }
    let(:expected_redirect_to) { %r{/admin/invoice_informations/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'PATCH /admin/invoice_informations/:id' do
    let!(:id) { invoice_information.id }
    let(:params) { attributes_for(:invoice_information) }
    let(:expected_redirect_to) { %r{/admin/invoice_informations/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end
end
