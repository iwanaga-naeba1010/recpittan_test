# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PartnersController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:custoemr) { create :user, :with_custoemr }

  before do
    sign_in partner
  end

  describe 'GET /index' do
    context 'with valid user' do
      it 'return http success' do
        get partners_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid user' do
      it 'return 302 when customer accessed' do
        sign_out partner
        sign_in custoemr
        get partners_path
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to root_path
      end

      it 'return 302 when user not logged in' do
        sign_out partner
        get partners_path
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
