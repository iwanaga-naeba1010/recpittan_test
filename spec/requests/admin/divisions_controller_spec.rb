# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Divisions', type: :request do
  include_context 'with authenticated admin'
  let!(:division) { create(:division) }

  describe 'GET /admin/divisions' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/divisions/:id' do
    let!(:id) { division.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/divisions/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/divisions/:id/edit' do
    let!(:id) { division.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/divisions' do
    let(:params) do
      { division: attributes_for(:division) }
    end
    let(:expected_redirect_to) { %r{/admin/divisions/\d+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'PATCH /admin/divisions/:id' do
    let!(:id) { division.id }
    let(:params) do
      { division: attributes_for(:division) }
    end
    let(:expected_redirect_to) { %r{/admin/divisions/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'DELETE #destroy' do
    context 'success' do
      it 'reduce one record' do
        expect { delete admin_division_path(division.id) }.to change(Division, :count).by(-1)
      end

      it 'redirects to managers company billboards path' do
        delete admin_division_path(division.id)
        expect(response).to redirect_to admin_divisions_path
      end
    end
  end
end
