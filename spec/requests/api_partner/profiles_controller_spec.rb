# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiPartner::ProfilesController, type: :request do
  include_context 'with authenticated partner'

  describe 'GET /api_partner/profiles' do
    let!(:profiles) { create_list(:profile, 5, user: current_user) }
    let(:expected) { ProfileSerializer.new.serialize_list(profiles:) }

    it_behaves_like 'an endpoint returns', :expected
  end
end
