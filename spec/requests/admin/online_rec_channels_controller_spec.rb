# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OnlineRecChannel', type: :request do
  include_context 'with authenticated admin'
  let(:online_rec_channel) { create :online_rec_channel }

  describe 'GET /admin/online_rec_channels' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/online_rec_channels/:id' do
    let!(:id) { online_rec_channel.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/online_rec_channels/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/online_rec_channels/:id/edit' do
    let!(:id) { online_rec_channel.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/online_rec_channels' do
    let(:params) { { online_rec_channel: attributes_for(:online_rec_channel) } }
    let(:expected_redirect_to) { %r{/admin/online_rec_channels/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'PATCH /admin/online_rec_channels/:id' do
    let!(:id) { online_rec_channel.id }
    let(:params) { attributes_for(:online_rec_channel) }
    let(:expected_redirect_to) { %r{/admin/online_rec_channels/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'DELETE /admin/online_rec_channels/:id' do
    let(:id) { online_rec_channel.id }
    let(:expected_redirect_to) { admin_online_rec_channels_path }
    it_behaves_like 'an endpoint returns 3xx status'
  end
end
