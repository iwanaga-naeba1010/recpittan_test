# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiPartner::EvaluationRepliesController, type: :request do
  include_context 'with authenticated partner'

  describe 'POST /api_partner/recreations/:evaluation_id/evaluation_replies' do
    let!(:user) { create(:user, :with_customer) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:order) { create(:order, recreation:, user:) }
    let!(:report) { create(:report, order:) }
    let!(:evaluation) { create(:evaluation, report:) }
    let(:evaluation_id) { recreation.id }
    let(:params) do
      {
        evaluation_reply: {
          evaluation_id: evaluation.id,
          message: 'message',
        }
      }
    end

    let(:expected) { EvaluationReplySerializer.new.serialize(evaluation_reply: EvaluationReply.last) }

    it_behaves_like 'an endpoint returns 2xx status', :expected

    context 'with invalid params' do
      let(:params) { { evaluation_reply: { message: '' } } }
      it_behaves_like 'an endpoint returns 4xx status'
    end
  end
end
