# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RecreationPlan', type: :request do
  include_context 'with authenticated admin'
  let(:recreation_plan) { create :recreation_plan }

  describe 'GET /admin/recreation_plans' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/recreation_plans/:id' do
    let!(:id) { recreation_plan.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/recreation_plans/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/recreation_plans/:id/edit' do
    let!(:id) { recreation_plan.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/recreation_plans' do
    let(:params) { { recreation_plan: attributes_for(:recreation_plan) } }

    it_behaves_like 'an endpoint returns 3xx status'
  end

  describe 'PATCH /admin/recreation_plans/:id' do
    let!(:id) { recreation_plan.id }
    let(:params) { attributes_for(:recreation_plan) }
    let(:expected_redirect_to) { %r{/admin/recreation_plans/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'DELETE /admin/recreation_plans/:id' do
    let(:id) { recreation_plan.id }
    let(:expected_redirect_to) { admin_recreation_plans_path }
    it_behaves_like 'an endpoint returns 3xx status'
  end
end
