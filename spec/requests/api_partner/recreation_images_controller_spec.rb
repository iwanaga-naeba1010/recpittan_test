# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiPartner::RecreationImagesController, type: :request do
  include_context 'with authenticated partner'

  describe 'POST /api_partner/recreations/:id/recreation_images' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation: recreation, profile: profile) }
    let(:id) { recreation.id }
    let(:params) do
      {
        recreation_image: {
          image: Rack::Test::UploadedFile.new('spec/files/test.png', 'image/png')
        }
      }
    end

    let(:expected) { RecreationImageSerializer.new.serialize(image: RecreationImage.last) }

    it_behaves_like 'an endpoint returns 2xx status', :expected

    context 'with valid params' do
      it_behaves_like 'an endpoint returns', :expected
    end

    context 'with invalid params' do
      let(:params) { { recreation_image: { image: '' } } }
      it_behaves_like 'an endpoint returns 4xx status'
    end
  end
end
