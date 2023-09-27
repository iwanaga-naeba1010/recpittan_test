# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiCustomer::FavoriteRecreationsController, type: :request do
  include_context 'with authenticated customer'
  let!(:customer) { create(:user, :with_customer) }
  let!(:recreation) { create(:recreation) }
  before do
    sign_in customer
  end

  describe 'GET /api_customer/favorite_recreations' do
    let!(:favorite_recreation) { create(:favorite_recreation, user: customer, recreation:) }

    let(:expected) { FavoriteRecreationSerializer.new.serialize_list(favorite_recreations: [favorite_recreation]) }
    it_behaves_like 'an endpoint returns', :expected
  end

  describe 'POST /api_customer/favorite_recreations' do
    let(:params) do
      {
        favorite_recreation: {
          recreation_id: recreation.id,
          user_id: customer.id
        }
      }
    end

    let(:expected) { FavoriteRecreationSerializer.new.serialize(favorite_recreation: FavoriteRecreation.last) }
    it_behaves_like 'an endpoint returns 2xx status', :expected
  end

  describe 'DELETE /api_customer/favorite_recreations/:id' do
    let!(:favorite_recreation) { create(:favorite_recreation, user: customer, recreation:) }
    let(:id) { favorite_recreation.id }
    let(:expected) { true }

    it_behaves_like 'an endpoint returns', :expected
  end
end
