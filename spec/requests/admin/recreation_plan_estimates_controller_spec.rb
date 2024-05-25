# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RecreationPlanEstimate', type: :request do
  include_context 'with authenticated admin'
  let(:recreation_plan_estimete) { create :recreation_plan_estimete }

  describe 'GET /admin/recreation_plan_estimetes' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/recreation_plan_estimetes/:id' do
    let!(:id) { recreation_plan_estimete.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end
end
