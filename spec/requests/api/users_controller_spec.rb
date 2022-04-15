# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::UsersController, type: :request do
  let(:customer) { create :user, :with_custoemr }

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
      it 'return http success' do
        sign_out customer
        get self_api_users_path
        # NOTE(okubo): 401にしたいけどdeviseとの干渉があるので302
        expect(response.status).to eq(302)
      end
    end
  end
end
