# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiPartner::RecreationImagesController, type: :request do
  include_context 'with authenticated partner'

  describe 'POST /api_partner/recreations/:recreation_id/recreation_images' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation: recreation, profile: profile) }
    let(:recreation_id) { recreation.id }
    let(:image) do
      base64_image = Base64.decode64(File.open(Rails.root.join('spec/files/test.png'), 'rb').read)
      "data:image/png;base64,#{base64_image}"
    end
    let(:params) do
      {
        recreation_image: {
          image: image
        }
      }
    end

    let(:expected) { RecreationImageSerializer.new.serialize(image: RecreationImage.last) }

    it_behaves_like 'an endpoint returns 2xx status', :expected

    context 'with invalid params' do
      let(:params) { { recreation_image: { image: '' } } }
      it_behaves_like 'an endpoint returns 4xx status'
    end
  end

  describe 'DELETE /api_partner/recreations/:recreation_id/recreation_images/:id' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation: recreation, profile: profile) }
    let!(:recreation_image) { create(:recreation_image, recreation: recreation) }
    let(:recreation_id) { recreation.id }
    let(:id) { recreation_image.id }
    let(:expected) { true }

    it_behaves_like 'an endpoint returns', :expected
  end
end
