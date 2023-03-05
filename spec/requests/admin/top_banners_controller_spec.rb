# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TopBanners', type: :request do
  include_context 'with authenticated admin'
  let(:top_banner) { create :top_banner }

  describe 'GET /admin/top_banners' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/top_banners/:id' do
    let!(:id) { top_banner.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/top_banners/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/top_banners/:id/edit' do
    let!(:id) { top_banner.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/top_banners' do
    let(:params) { { top_banner: attributes_for(:top_banner) } }
    let(:expected_redirect_to) { %r{/admin/top_banners/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'PATCH /admin/top_banners/:id' do
    let!(:id) { top_banner.id }
    let(:params) { attributes_for(:top_banner) }
    let(:expected_redirect_to) { %r{/admin/top_banners/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'DELETE /admin/top_banners/:id' do
    let(:id) { top_banner.id }
    let(:expected_redirect_to) { admin_top_banners_path }
    it_behaves_like 'an endpoint returns 3xx status'
  end
end
