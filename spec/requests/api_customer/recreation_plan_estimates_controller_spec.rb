# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiCustomer::RecreationPlanEstimatesController, type: :request do
  include_context 'with authenticated customer'

  describe 'POST /api_customer/recreation_plan_estimates' do
    let!(:recreation_plan) { create(:recreation_plan) }
    let(:params) do
      {
        recreation_plan_estimate: {
          start_month: 1,
          transportation_expenses: 1000,
          recreation_plan_id: recreation_plan.id
        }
      }
    end
    let(:expected) { RecreationPlanEstimateSerializer.new.serialize(recreation_plan_estimate: RecreationPlanEstimate.last) }

    it_behaves_like 'an endpoint returns 2xx status', :expected

    context 'with valid params' do
      it_behaves_like 'an endpoint returns', :expected
    end
  end
end
