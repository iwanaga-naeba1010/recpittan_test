# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profiles', type: :request do
  include_context 'with authenticated admin'
  let!(:partner) { create :user, :with_partner }
  let!(:profile) { create :profile, user: partner }

  describe 'GET /admin/profiles' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/profiles/:id' do
    let!(:id) { profile.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/profiles/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/profiles/:id/edit' do
    let!(:id) { profile.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/profiles' do
    let(:params) { { profile: attributes_for(:profile, user_id: partner.id) } }
    let(:expected_redirect_to) { %r{/admin/profiles/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'PATCH /admin/profiles/:id' do
    let!(:id) { profile.id }
    let(:params) { attributes_for(:profile, user: partner) }
    let(:expected_redirect_to) { %r{/admin/profiles/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'DELETE /admin/profiles/:id' do
    let(:id) { profile.id }
    let(:expected_redirect_to) { admin_profiles_path }
    it_behaves_like 'an endpoint returns 3xx status'
  end
end
