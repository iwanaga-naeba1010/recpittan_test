# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tags::Target', type: :request do
  include_context 'with authenticated admin'
  let!(:tag) { create(:tag, kind: :target) }

  describe 'GET /admin/tags_targets' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/tags_targets/:id' do
    let!(:id) { tag.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/tags_targets/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/tags_targets/:id/edit' do
    let!(:id) { tag.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/tags_targets' do
    let(:params) { { tags_tag: attributes_for(:tag) } }
    let(:expected_redirect_to) { %r{/admin/tags_targets/\d+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'PATCH /admin/tags_targets/:id' do
    let!(:id) { tag.id }
    let(:params) { attributes_for(:tag) }
    let(:expected_redirect_to) { %r{/admin/tags_targets/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'DELETE /admin/tags_targets/:id' do
    let(:id) { tag.id }
    let(:expected_redirect_to) { admin_tags_targets_path }
    it_behaves_like 'an endpoint returns 3xx status'
  end
end
