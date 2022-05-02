# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  let(:admin) { create :user, :with_admin }
  let!(:customer) { create :user, :with_customer }
  let!(:company) { customer.company }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'return http success' do
      get admin_companies_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'return http success' do
      get admin_company_path(company.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    let(:attrs) { attributes_for(:company).merge(user_attributes: attributes_for(:user)) }

    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post admin_companies_path, params: { company: attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(admin_company_path(Company.last.id))
      end

      it 'can create user_company and increase one company record' do
        expect {
          post admin_companies_path, params: { company: attrs }
        }.to change(Company, :count).by(+1)
      end

      it 'can create user_company and increase one user record' do
        expect {
          post admin_companies_path, params: { company: attrs }
        }.to change(User, :count).by(+1)
      end

      it 'can create user with customer role' do
        post admin_companies_path, params: { company: attrs }
        expect(User.last.role).to eq :customer
      end
    end

    # TODO: 失敗パターンも実装
    context 'with invalid parameters' do
    end
  end

  describe 'GET #edit' do
    it 'return http success' do
      get edit_admin_company_path(company.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update' do
    context 'when valid parameters' do
      name = 'update company name'
      it 'returns 302 status' do
        put admin_company_path(company.id), params: { company: { name: name } }
        expect(response).to have_http_status(:found)
      end

      it 'update status' do
        expect {
          put admin_company_path(company.id), params: { company: { name: name } }
        }.to change { Company.find(company.id).name }.from(company.name).to(name)
      end
    end
  end

  # describe 'DELETE #destroy' do
  #   context 'success' do
  #     it 'reduce one record' do
  #       expect { delete admin_company_path(company.id) }.to change(Company, :count).by(-1)
  #     end
  #
  #     it 'redirects to managers company billboards path' do
  #       delete admin_company_path(company.id)
  #       expect(response).to redirect_to admin_companies_path
  #     end
  #   end
  # end
end
