# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resources::Recreations::Create, type: :interaction do
  describe '#execute' do
    let!(:partner) { create(:user, role: :partner) }
    let!(:profile) { create(:profile, user: partner) }

    subject do
      Resources::Recreations::Create.run!(
        recreation_params: attributes_for(:recreation, user: partner),
        current_user: partner,
        profile_id: profile.id
      )
    end

    it 'should create a recreation' do
      expect { subject }.to change { Recreation.count }.from(0).to(1)
    end
  end
end
