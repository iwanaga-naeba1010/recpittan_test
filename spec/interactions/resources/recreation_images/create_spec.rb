# frozen_string_literal: true

require 'rails_helper'
require 'base64'

RSpec.describe Resources::RecreationImages::Create, type: :interaction do
  describe '#execute' do
    let!(:partner) { create(:user, role: :partner) }
    let!(:profile) { create(:profile, user: partner) }
    let!(:recreation) { create(:recreation, user: partner, profile: profile) }

    let(:image) do
      base64_image = Base64.decode64(File.binread(Rails.root.join('spec/files/test.png')))
      "data:image/png;base64,#{base64_image}"
    end
    let(:params) do
      {
        image: image
      }
    end

    subject do
      Resources::RecreationImages::Create.run!(
        params: params,
        recreation_id: recreation.id
      )
    end

    it 'should create a recreation' do
      expect { subject }.to change { RecreationImage.count }.from(0).to(1)
    end
  end
end
