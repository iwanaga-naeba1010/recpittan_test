# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OnlineRecreationChannel', type: :request do
  include_context 'with authenticated admin'
  let(:online_recreation_channel) { create :online_recreation_channel }

  describe 'GET /admin/online_recreation_channels' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/online_recreation_channels/:id' do
    let!(:id) { online_recreation_channel.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/online_recreation_channels/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/online_recreation_channels/:id/edit' do
    let!(:id) { online_recreation_channel.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/online_recreation_channels' do
    let(:params) { { online_recreation_channel: attributes_for(:online_recreation_channel) } }
    let(:expected_redirect_to) { %r{/admin/online_recreation_channels/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'PATCH /admin/online_recreation_channels/:id' do
    let!(:id) { online_recreation_channel.id }
    let(:params) { attributes_for(:online_recreation_channel) }
    let(:expected_redirect_to) { %r{/admin/online_recreation_channels/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'DELETE /admin/online_recreation_channels/:id' do
    let(:id) { online_recreation_channel.id }
    let(:expected_redirect_to) { admin_online_recreation_channels_path }
    it_behaves_like 'an endpoint returns 3xx status'
  end
end
