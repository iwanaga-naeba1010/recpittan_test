# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tags', type: :request do
  include_context 'with authenticated admin'
  let!(:tag) { create(:tag) }

  describe 'GET /admin/tags_tags' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/tags_tags/:id' do
    let!(:id) { tag.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/tags_tags/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/tags_tags/:id/edit' do
    let!(:id) { tag.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/tags_tags' do
    let(:params) { { tags_tag: attributes_for(:tag) } }
    let(:expected_redirect_to) { %r{/admin/tags_tags/\d+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'PATCH /admin/tags_tags/:id' do
    let!(:id) { tag.id }
    let(:params) { attributes_for(:tag) }
    let(:expected_redirect_to) { %r{/admin/tags_tags/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  # NOTE(okubo): deleteないのでコメントアウト
  describe 'DELETE /admin/tags_tags/:id' do
    let(:id) { tag.id }
    let(:expected_redirect_to) { admin_tags_tags_path }
    it_behaves_like 'an endpoint returns 3xx status'
  end
end
