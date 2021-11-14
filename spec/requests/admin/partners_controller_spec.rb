# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Partners', type: :request do
  let(:admin) { create :user, :with_admin }
  let(:customer) { create :user, :with_custoemr }
  let(:partner) { (create :user, :with_partner).partner }
  # let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'return http success' do
      get admin_partners_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'return http success' do
      get admin_partner_path(partner.id)
      expect(response).to have_http_status(:ok)
    end
  end

  # TODO: controllerを修正したらテストも追加
  pending do
    describe 'POST #create' do
      let(:attrs) { attributes_for(:partner) }

      context 'with valid parameters' do
        it 'return http success when user not logged in' do
          post admin_partners_path, params: { partner: attrs }
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(admin_partner_path(Partner.last.id))
        end

        it 'can create user_company and increase one record' do
          expect {
            post admin_partners_path, params: { partner: attrs }
          }.to change(Partner, :count).by(+1)
        end
      end

      # TODO: 失敗パターンも実装
      context 'with invalid parameters' do
      end
    end
  end

  describe 'GET #edit' do
    it 'return http success' do
      get edit_admin_partner_path(partner.id)
      expect(response).to have_http_status(:ok)
    end
  end

  # TODO: controllerを修正したらテストも追加
  pending do
    describe 'PUT #update' do
      context 'when valid parameters' do
        number_of_people = 10
        it 'returns 302 status' do
          put admin_order_path(order.id), params: { order: { number_of_people: number_of_people } }
          expect(response).to have_http_status(:found)
        end

        it 'update status' do
          expect {
            put admin_order_path(order.id), params: { order: { number_of_people: number_of_people } }
          }.to change { Order.find(order.id).number_of_people }.from(order.number_of_people).to(number_of_people)
        end
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
