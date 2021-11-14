# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  let(:admin) { create :user, :with_admin }
  let(:cs) { create :user, :with_cs }
  let(:customer) { create :user, :with_custoemr }
  let(:partner) { create :user, :with_partner }

  before do
    sign_in admin
  end

  # NOTE: 他のroutesではここまでやらないので、ここで権限を確認
  describe 'GET /dashboard' do
    context 'with valid user' do
      it 'return http success when admin user logged in' do
        get admin_dashboard_path
        expect(response).to have_http_status(:ok)
      end

      it 'return http success when cs user logged in' do
        sign_out admin
        sign_in cs
        get admin_dashboard_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid user' do
      it 'return 302 when customer accessed' do
        sign_out admin
        sign_in customer
        get admin_dashboard_path
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end

      it 'return 302 when partner accessed' do
        sign_out admin
        sign_in partner
        get admin_dashboard_path
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
