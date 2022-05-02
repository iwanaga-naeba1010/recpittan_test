# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::UsersController, type: :request do
  let(:customer) { create :user, :with_customer }
  let(:partner) { create :user, :with_recreations }

  before do
    sign_in customer
  end

  describe 'GET /' do
    context 'with valid user' do
      it 'return http success' do
        get self_api_users_path
        expect(response.status).to eq(200)
      end
    end

    context 'with valid user' do
      it 'returns unauthorized' do
        sign_out customer
        get self_api_users_path
        # NOTE(okubo): 401にしたいが、deviseの影響でredirectされてしまう
        expect(response.status).to eq(302)
      end
    end
  end
end
