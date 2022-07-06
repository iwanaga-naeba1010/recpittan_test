# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resources::RecreationPrefectures::Update, type: :interaction do
  describe '#execute' do
    let!(:partner) { create(:user, role: :partner) }
    let!(:profile) { create(:profile, user: partner) }
    let!(:recreation) { create(:recreation, user: partner, profile: profile) }
    let!(:recreation_prefecture) { create(:recreation_prefecture, recreation: recreation) }

    let(:params) do
      {
        name: '愛知県'
      }
    end

    subject do
      Resources::RecreationPrefectures::Update.run!(
        params: params,
        id: recreation_prefecture.id,
        recreation_id: recreation.id
      )
    end

    it 'should update a recreation prefecture' do
      expect { subject }
        .to change { RecreationPrefecture.find(recreation_prefecture.id).name }
        .from(recreation_prefecture.name).to(params[:name])
    end
  end
end
