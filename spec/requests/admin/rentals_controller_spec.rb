# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tags::Rentals', type: :request do
  include_context 'with authenticated admin'
  let!(:tag) { create(:tag, kind: :rental) }

  describe 'GET /admin/tags_rentals' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/tags_rentals/:id' do
    let!(:id) { tag.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/tags_rentals/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/tags_rentals/:id/edit' do
    let!(:id) { tag.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/tags_rentals' do
    let(:params) { { tags_tag: attributes_for(:tag) } }
    let(:expected_redirect_to) { %r{/admin/tags_rentals/\d+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'PATCH /admin/tags_rentals/:id' do
    let!(:id) { tag.id }
    let(:params) { attributes_for(:tag) }
    let(:expected_redirect_to) { %r{/admin/tags_rentals/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'DELETE /admin/tags_rentals/:id' do
    let(:id) { tag.id }
    let(:expected_redirect_to) { admin_tags_rentals_path }
    it_behaves_like 'an endpoint returns 3xx status'
  end
end
