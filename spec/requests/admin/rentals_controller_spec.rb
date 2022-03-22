# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tags::Rentals', type: :request do
  let(:admin) { create :user, :with_admin }
  let!(:tag) { create :tag, kind: :rental }

  before do
    sign_in admin
  end

  describe 'GET #index' do
    it 'return http success' do
      get admin_tags_rentals_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET #show' do
    it 'return http success' do
      get admin_tags_rental_path(tag.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    let(:attrs) { attributes_for(:tag, kind: :rental) }

    context 'with valid parameters' do
      it 'return http success when user not logged in' do
        post admin_tags_rentals_path, params: { tag: attrs }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(admin_tags_rental_path(Tag.last.id))
      end

      it 'can create tag and increase one record' do
        expect {
          post admin_tags_rentals_path, params: { tags_rental: attrs }
        }.to change(Tag, :count).by(+1)
      end

      it 'can create tag with :tag kind' do
        post admin_tags_rentals_path, params: { tags_rental: attrs }
        expect(Tag.last.kind).to eq :rental
      end
    end

    # TODO: 失敗パターンも実装
    context 'with invalid parameters' do
    end
  end

  describe 'GET #edit' do
    it 'return http success' do
      get edit_admin_tags_rental_path(tag.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT #update' do
    context 'when valid parameters' do
      name = 'update tag name'
      it 'returns 302 status' do
        put admin_tags_rental_path(tag.id), params: { tags_rental: { name: name } }
        expect(response).to have_http_status(:found)
      end

      it 'update status' do
        expect {
          put admin_tags_rental_path(tag.id), params: { tags_rental: { name: name } }
        }.to change { Tag.find(tag.id).name }.from(tag.name).to(name)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'success' do
      it 'reduce one record' do
        expect { delete admin_tags_rental_path(tag.id) }.to change(Tag, :count).by(-1)
      end

      it 'redirects to managers company billboards path' do
        delete admin_tags_rental_path(tag.id)
        expect(response).to redirect_to admin_tags_rentals_path
      end
    end
  end
end
