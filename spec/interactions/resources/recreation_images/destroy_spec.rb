# frozen_string_literal: true

require 'rails_helper'
require 'base64'

RSpec.describe Resources::RecreationImages::Destroy, type: :interaction do
  describe '#execute' do
    let!(:partner) { create(:user, role: :partner) }
    let!(:profile) { create(:profile, user: partner) }
    let!(:recreation) { create(:recreation, user: partner, profile:) }
    let!(:recreation_image) { create(:recreation_image, recreation:) }

    let(:params) do
      {
        id: recreation_image.id
      }
    end

    subject do
      Resources::RecreationImages::Destroy.run!(recreation_image_id: recreation_image.id)
    end

    it 'should create a recreation' do
      expect { subject }.to change { RecreationImage.count }.from(1).to(0)
    end
  end
end
