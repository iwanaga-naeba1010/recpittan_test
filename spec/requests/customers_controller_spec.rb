# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomersController, type: :request do
  let(:user) { create :user, :with_custoemr }
  let(:partner) { create :user, :with_partner }

  before do
    sign_in user
  end

  describe 'GET /index' do
    context 'with valid user' do
      it 'return http success' do
        get customers_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid user' do
      it 'return 302 when partner accessed' do
        sign_out user
        sign_in partner
        get customers_path
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end

      it 'return 302 when user not logged in' do
        sign_out user
        get customers_path
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
