# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customers::EvaluationsController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:recreation) { partner.recreations.first }

  describe 'GET /customers/evaluations' do
    let!(:id) { recreation.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end
end
