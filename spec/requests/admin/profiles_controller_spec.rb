# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  let!(:admin) { create :user, :with_admin }
  let!(:partner) { create :user, :with_recreations }
  let!(:profile) { create :profile, user: partner }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'return http success' do
      get admin_profiles_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'return http success' do
      get admin_profile_path(profile.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    let(:attrs) { attributes_for(:profile, user_id: partner.id) }

    context 'with valid parameters' do
      it 'return http success' do
        post admin_profiles_path, params: { profile: attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(admin_profile_path(Profile.last.id))
      end

      it 'can create partner and increase one record' do
        expect {
          post admin_profiles_path, params: { profile: attrs }
        }.to change(Profile, :count).by(+1)
      end
    end

    # TODO: 失敗パターンも実装
    context 'with invalid parameters' do
    end
  end

  describe 'GET #edit' do
    it 'return http success' do
      get edit_admin_profile_path(profile.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update' do
    context 'when valid parameters' do
      name = 'update profile name'
      it 'returns 302 status' do
        put admin_profile_path(profile.id), params: { profile: { name: name } }
        expect(response).to have_http_status(:found)
      end

      it 'update status' do
        expect {
          put admin_profile_path(profile.id), params: { profile: { name: name } }
        }.to change { Profile.find(profile.id).name }.from(profile.name).to(name)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'success' do
      it 'reduce one record' do
        expect { delete admin_profile_path(profile.id) }.to change(Profile, :count).by(-1)
      end

      it 'redirects to managers company billboards path' do
        delete admin_profile_path(profile.id)
        expect(response).to redirect_to admin_profiles_path
      end
    end
  end
end
