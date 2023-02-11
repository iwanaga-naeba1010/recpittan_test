# frozen_string_literal: true

require 'rails_helper'
require 'base64'

RSpec.describe ApiPartner::RecreationImagesController, type: :request do
  include_context 'with authenticated partner'

  describe 'POST /api_partner/recreations/:recreation_id/recreation_images' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation:, profile:) }
    let(:recreation_id) { recreation.id }
    let(:image) do
      # NOTE(okubo): こちら直したいが、多分shiftJSが問題。interactionは通るので、req送るタイミングの問題なはず
      base64_image = Base64.decode64(Rails.root.join('spec/files/test.png').binread)
      "data:image/png;base64,#{base64_image}"
    end
    let(:params) do
      {
        recreation_image: {
          image:,
          filename: 'filename',
          kind: :slider
        }
      }
    end

    let(:expected) { RecreationImageSerializer.new.serialize(recreation_image: RecreationImage.last) }

    it_behaves_like 'an endpoint returns 2xx status', :expected

    # context 'with invalid params' do
    #   let(:params) { { recreation_image: { image: '' } } }
    #   it_behaves_like 'an endpoint returns 4xx status'
    # end
  end

  describe 'DELETE /api_partner/recreations/:recreation_id/recreation_images/:id' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation:, profile:) }
    let!(:recreation_image) { create(:recreation_image, recreation:) }
    let(:recreation_id) { recreation.id }
    let(:id) { recreation_image.id }
    let(:expected) { true }

    it_behaves_like 'an endpoint returns', :expected
  end
end
