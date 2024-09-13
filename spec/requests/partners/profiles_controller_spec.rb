# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe Partners::ProfilesController, type: :request do
  let!(:partner) { create :user, :with_recreations }
  let!(:profile) { create :profile, user: partner }

  before do
    sign_in partner
  end

  describe 'GET /index' do
    context 'with valid right' do
      it 'returns http success' do
        get partners_profiles_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /new' do
    context 'with valid right' do
      it 'returns http success' do
        get new_partners_profile_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /create' do
    let(:attrs) { attributes_for(:profile, user_id: partner.id) }

    context 'when valid parameters' do
      it 'returns 302 status after created' do
        post partners_profiles_path, params: { profile: attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to partners_recreations_path
      end

      it 'can create profile and increase one record' do
        expect {
          post partners_profiles_path, params: { profile: attrs }
        }.to change(Profile, :count).by(+1)
      end
    end
  end

  describe 'GET /edit' do
    context 'with valid right' do
      it 'returns http success' do
        get edit_partners_profile_path(profile.id)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'PUT /update' do
    context 'when valid parameters' do
      name = 'update profile name'
      it 'returns 302 status' do
        put partners_profile_path(profile.id), params: { profile: { name: } }
        expect(response).to have_http_status(:found)
      end

      it 'update status' do
        expect {
          put partners_profile_path(profile.id), params: { profile: { name: } }
        }.to change { Profile.find(profile.id).name }.from(profile.name).to(name)
      end
    end

    context 'with invalid right' do
      it 'redirects to root path when role is read' do
        put partners_profile_path(profile.id), params: { profile: { title: 'profile_name' } }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to partners_profiles_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'success' do
      it 'reduce one record' do
        expect { delete partners_profile_path(profile.id) }.to change(Profile, :count).by(-1)
      end

      it 'redirects to partners profiles path' do
        delete partners_profile_path(profile.id)
        expect(response).to redirect_to partners_profiles_path
      end
    end
  end
end
