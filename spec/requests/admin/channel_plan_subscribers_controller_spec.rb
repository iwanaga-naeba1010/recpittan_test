# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ChannelPlanSubscriber', type: :request do
  include_context 'with authenticated admin'
  let(:channel_plan_subscriber) { create :channel_plan_subscriber }

  describe 'GET /admin/channel_plan_subscribers' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/channel_plan_subscribers/:id' do
    let!(:id) { channel_plan_subscriber.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/channel_plan_subscribers/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/channel_plan_subscribers/:id/edit' do
    let!(:id) { channel_plan_subscriber.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/channel_plan_subscribers' do
    let(:params) { { channel_plan_subscriber: attributes_for(:channel_plan_subscriber) } }

    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'PATCH /admin/channel_plan_subscribers/:id' do
    let!(:id) { channel_plan_subscriber.id }
    let(:params) { attributes_for(:channel_plan_subscriber) }
    let(:expected_redirect_to) { %r{/admin/channel_plan_subscribers/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'DELETE /admin/channel_plan_subscribers/:id' do
    let(:id) { channel_plan_subscriber.id }
    let(:expected_redirect_to) { admin_channel_plan_subscribers_path }
    it_behaves_like 'an endpoint returns 3xx status'
  end
end
