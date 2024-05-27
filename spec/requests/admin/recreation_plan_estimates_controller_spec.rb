# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RecreationPlanEstimate', type: :request do
  include_context 'with authenticated admin'
  let(:recreation_plan_estimate) { create :recreation_plan_estimate }

  describe 'GET /admin/recreation_plan_estimates' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/recreation_plan_estimates/:id' do
    let!(:id) { recreation_plan_estimate.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end
end
