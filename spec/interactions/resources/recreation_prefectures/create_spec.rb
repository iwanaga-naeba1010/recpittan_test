# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resources::RecreationPrefectures::Create, type: :interaction do
  describe '#execute' do
    let!(:partner) { create(:user, role: :partner) }
    let!(:profile) { create(:profile, user: partner) }
    let!(:recreation) { create(:recreation, user: partner, profile:) }

    let(:params) do
      {
        name: '北海道'
      }
    end

    subject do
      Resources::RecreationPrefectures::Create.run!(
        params:,
        recreation_id: recreation.id
      )
    end

    it 'should create a recreation prefecture' do
      expect { subject }.to change { RecreationPrefecture.count }.from(0).to(1)
    end
  end
end
