# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::SlackNotifiersController, type: :request do
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_customer }
  let(:recreation) { partner.recreations.first }

  before do
    sign_in customer
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post api_slack_notifiers_path, params: { recreation_id: recreation.id }
        expect(response.status).to eq 200
      end
    end

    # TODO: 失敗パターンも実装
    context 'with invalid parameters' do
    end
  end
end
