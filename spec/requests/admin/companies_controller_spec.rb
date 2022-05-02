# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  include_context 'with authenticated admin'
  let!(:customer) { create(:user, :with_customer) }
  let!(:company) { customer.company }

  describe 'GET /admin/companies' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/companies/:id' do
    let!(:id) { company.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/companies/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/companies/:id/edit' do
    let!(:id) { company.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/companies' do
    let(:params) do
      { company: attributes_for(:company).merge({ user_attributes: attributes_for(:user) }) }
    end
    let(:expected_redirect_to) { %r{/admin/companies/\d+} }

    it_behaves_like 'an endpoint redirects match'

    context 'with invalid params' do
      let(:params) { { company: {} } }

      it_behaves_like 'an endpoint returns 2xx status'
    end
  end

  describe 'PATCH /admin/companies/:id' do
    let!(:id) { company.id }
    let(:params) { attributes_for(:company) }
    let(:expected_redirect_to) { %r{/admin/companies/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end
end
