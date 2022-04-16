# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiCustomer::UsersController, type: :request do
  let(:customer) { create :user, :with_custoemr }
  let(:partner) { create :user, :with_recreations }

  before do
    sign_in customer
  end

  describe 'GET /' do
    context 'with valid user' do
      it 'return http success' do
        get self_api_customer_users_path
        expect(response.status).to eq(200)
      end
    end

    context 'with valid user' do
      it 'returns unauthorized' do
        sign_out customer
        sign_in partner
        get self_api_customer_users_path
        expect(response.status).to eq(401)
      end
    end
  end
end
