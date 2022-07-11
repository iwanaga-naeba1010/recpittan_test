# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resources::RecreationPrefectures::Destroy, type: :interaction do
  describe '#execute' do
    let!(:partner) { create(:user, role: :partner) }
    let!(:profile) { create(:profile, user: partner) }
    let!(:recreation) { create(:recreation, user: partner, profile: profile) }
    let!(:recreation_prefecture) { create(:recreation_prefecture, recreation: recreation) }

    let(:params) do
      {
        id: recreation_image.id
      }
    end

    subject do
      Resources::RecreationPrefectures::Destroy.run!(recreation_prefecture_id: recreation_prefecture.id)
    end

    it 'should create a recreation prefecture' do
      expect { subject }.to change { RecreationPrefecture.count }.from(1).to(0)
    end
  end
end
