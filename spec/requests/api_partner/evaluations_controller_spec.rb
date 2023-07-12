# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiPartner::EvaluationsController, type: :request do
  include_context 'with authenticated partner'

  describe 'GET /api_partner/recreations/:id/evaluations' do
    let!(:user) { create(:user, :with_customer) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:order) { create(:order, recreation:, user:) }
    let!(:report) { create(:report, order:) }
    let!(:evaluation) { create(:evaluation, report:) }
    let(:id) { recreation.id }
    let(:expected) { EvaluationSerializer.new.serialize_list(evaluations: [evaluation]) }

    it_behaves_like 'an endpoint returns', :expected
  end
end
