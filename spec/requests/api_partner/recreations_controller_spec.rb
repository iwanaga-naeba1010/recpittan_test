# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiPartner::ProfilesController, type: :request do
  include_context 'with authenticated partner'

  describe 'GET /api_partner/recreations/config_data' do
    let(:expected) { { categories: Recreation.category.values.map(&:text) } }
    it_behaves_like 'an endpoint returns', :expected
  end

  describe 'GET /api_partner/recreations/:id' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation: recreation, profile: profile) }
    let(:id) { recreation.id }
    let(:expected) { RecreationSerializer.new.serialize(recreation: recreation) }

    it_behaves_like 'an endpoint returns', :expected
  end

  describe 'POST /api_partner/recreations' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation: recreation, profile: profile) }
    let(:id) { recreation.id }
    let(:params) do
      {
        recreation: attributes_for(
          :recreation,
          user: current_user,
          recreation_profile_attributes: { profile_id: profile.id }
        )
      }
    end
    let(:expected) { RecreationSerializer.new.serialize(recreation: Recreation.last) }

    it_behaves_like 'an endpoint returns 2xx status', :expected

    context 'with valid params' do
      it_behaves_like 'an endpoint returns', :expected
    end

    context 'with invalid params' do
      let(:params) { { recreation: attributes_for(:recreation) } }
      it_behaves_like 'an endpoint returns 4xx status'
    end
  end

  describe 'PATCH /api_partner/recreations/:id' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation: recreation, profile: profile) }
    let(:id) { recreation.id }
    let!(:params) { { recreation: attributes_for(:recreation, user: current_user) } }
    let(:expected) { RecreationSerializer.new.serialize(recreation: recreation) }

    it_behaves_like 'an endpoint returns', :expected

    context 'with valid params' do
      it_behaves_like 'an endpoint returns 2xx status'
    end

    context 'with invalid params' do
      let!(:params) { { recreation: { recreation_profile_attributes: { profile_id: 0 } } } }
      it_behaves_like 'an endpoint returns 4xx status', :expected
    end
  end
end
