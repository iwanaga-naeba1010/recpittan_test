# frozen_string_literal: true

require 'rails_helper'
require 'base64'

RSpec.describe ApiPartner::RecreationPrefecturesController, type: :request do
  include_context 'with authenticated partner'

  describe 'POST /api_partner/recreations/:recreation_id/recreation_prefectures' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation:, profile:) }
    let(:recreation_id) { recreation.id }
    let(:params) do
      {
        recreation_prefecture: {
          name: '北海道'
        }
      }
    end

    let(:expected) { RecreationPrefectureSerializer.new.serialize(recreation_prefecture: RecreationPrefecture.last) }

    it_behaves_like 'an endpoint returns 2xx status', :expected

    # context 'with invalid params' do
    #   let(:params) { { recreation_image: { image: '' } } }
    #   it_behaves_like 'an endpoint returns 4xx status'
    # end
  end

  describe 'PATCH /api_partner/recreations/:recreation_id/recreation_prefectures/:id' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation:, profile:) }
    let!(:recreation_prefecture) { create(:recreation_prefecture, recreation_id: recreation.id) }
    let(:recreation_id) { recreation.id }
    let(:id) { recreation_prefecture.id }
    let(:params) do
      {
        recreation_prefecture: {
          name: '愛知県'
        }
      }
    end

    let(:expected) do
      RecreationPrefectureSerializer.new.serialize(recreation_prefecture: recreation_prefecture.reload)
    end

    it_behaves_like 'an endpoint returns', :expected

    context 'with valid params' do
      let(:params) { { recreation_prefecture: { name: '' } } }

      it_behaves_like 'an endpoint returns 4xx status'
    end
    # context 'with invalid params' do
    #   let(:params) { { recreation_image: { image: '' } } }
    #   it_behaves_like 'an endpoint returns 4xx status'
    # end
  end

  describe 'DELETE /api_partner/recreations/:recreation_id/recreation_prefectures/:id' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation:, profile:) }
    let!(:recreation_prefecture) { create(:recreation_prefecture, recreation:) }
    let(:recreation_id) { recreation.id }
    let(:id) { recreation_prefecture.id }
    let(:expected) { true }

    it_behaves_like 'an endpoint returns', :expected
  end
end
