# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::SystemParameters', type: :request do
  include_context 'with authenticated admin'
  let!(:system_parameter) { create(:system_parameter) }

  describe 'GET /admin/system_parameters' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/system_parameters/:id' do
    let!(:id) { system_parameter.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/system_parameters/new' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/system_parameters/:id/edit' do
    let!(:id) { system_parameter.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/system_parameters' do
    let(:params) do
      { system_parameter: attributes_for(:system_parameter) }
    end
    let(:expected_redirect_to) { %r{/admin/system_parameters/\d+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'PATCH /admin/system_parameters/:id' do
    let!(:id) { system_parameter.id }
    let(:params) do
      { system_parameter: attributes_for(:system_parameter) }
    end
    let(:expected_redirect_to) { %r{/admin/system_parameters/[0-9]+} }

    it_behaves_like 'an endpoint redirects match'
  end

  describe 'DELETE #destroy' do
    context 'success' do
      it 'reduce one record' do
        expect { delete admin_system_parameter_path(system_parameter.id) }.to change(SystemParameter, :count).by(-1)
      end

      it 'redirects to managers company billboards path' do
        delete admin_system_parameter_path(system_parameter.id)
        expect(response).to redirect_to admin_system_parameters_path
      end
    end
  end
end
