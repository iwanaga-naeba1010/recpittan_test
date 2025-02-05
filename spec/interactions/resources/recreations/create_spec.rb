# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resources::Recreations::Create, type: :interaction do
  describe '#execute' do
    let!(:partner) { create(:user, role: :partner) }
    let!(:profile) { create(:profile, user: partner) }
    let(:params) do
      attributes_for(
        :recreation,
        title: 'title',
        second_title: 'second_title',
        price: 5000,
        material_price: 1000,
        minutes: 30,
        description: 'description',
        flow_of_day: '',
        borrow_item: '',
        bring_your_own_item: '',
        extra_information: '',
        youtube_id: '',
        capacity: 1,
        additional_facility_fee: 0,
        category: 'event',
        status: 'in_progress',
        kind: 'online'
      )
    end

    subject do
      Resources::Recreations::Create.run!(
        recreation_params: params,
        current_user: partner,
        profile_id: profile.id
      )
    end

    it 'should create a recreation' do
      expect { subject }.to change { Recreation.count }.from(0).to(1)
    end
  end
end
