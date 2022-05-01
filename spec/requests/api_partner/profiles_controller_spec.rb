# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiPartner::ProfilesController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:profile) { create :profile, user: partner }

  before do
    sign_in partner
  end

  describe 'GET /index' do
    context 'with valid parameters' do
      it 'return http success' do
        get api_partner_profiles_path
        expect(response.status).to eq(200)
      end
    end
  end
end
