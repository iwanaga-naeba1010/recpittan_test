# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customers::RecreationsController, type: :request do
  let(:user) { create :user, :with_customer }
  let(:partner) { create :user, :with_recreations }
  let(:recreation) { partner.recreations.first }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'return http success when user not logged in' do
      sign_out user
      get customers_recreations_path
      expect(response).to have_http_status(:ok)
    end

    it 'return http success when user not logged in' do
      get customers_recreations_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /show' do
    it 'returns http success when user logged in' do
      get customers_recreation_path(recreation)
      expect(response).to have_http_status(:ok)
    end

    it 'return http success when user not logged in' do
      sign_out user
      get customers_recreation_path(recreation)
      expect(response).to have_http_status(:ok)
    end
  end
end
