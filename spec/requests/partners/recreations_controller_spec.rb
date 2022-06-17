# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::RecreationsController, type: :request do
  include_context 'with authenticated partner'

  let(:partner) { current_user }
  let(:customer) { create :user, :with_customer }
  let!(:recreation) { create(:recreation, user: current_user) }

  describe 'GET /partners/recreations' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /partners/recreations/:id' do
    let!(:id) { recreation.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /partners/recreations/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /partners/recreations/:id/edit' do
    let!(:id) { recreation.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end
end
