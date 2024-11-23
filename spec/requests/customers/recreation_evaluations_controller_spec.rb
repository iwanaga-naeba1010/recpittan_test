# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customers::RecreationEvaluationsController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:recreation) { partner.recreations.first }

  describe 'GET /customers/recreations/:recreation_id/evaluations' do
    let!(:recreation_id) { recreation.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end
end
