# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiPartner::RecreationsController, type: :request do
  include_context 'with authenticated partner'

  describe 'GET /api_partner/recreations/config_data' do
    let(:expected) do
      {
        categories: Recreation.category.values.map { |category| { name: category.text, enum_key: category } },
        minutes: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60], # TODO(okubo): 後々綺麗にする
        prefectures: RecreationPrefecture.names,
        kind: Recreation.kind.values.map { |kind| { name: kind.text, enum_key: kind } }
      }
    end
    it_behaves_like 'an endpoint returns', :expected
  end

  describe 'GET /api_partner/recreations' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation:, profile:) }
    let(:id) { recreation.id }
    let(:expected) { RecreationSerializer.new.serialize_list(recreations: [recreation]) }

    it_behaves_like 'an endpoint returns', :expected
  end

  describe 'GET /api_partner/recreations/:id' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation:, profile:) }
    let(:id) { recreation.id }
    let(:expected) { RecreationSerializer.new.serialize(recreation:) }

    it_behaves_like 'an endpoint returns', :expected
  end

  describe 'POST /api_partner/recreations' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation:, profile:) }
    let(:id) { recreation.id }
    let(:params) do
      {
        recreation: {
          title: 'title',
          second_title: 'second_title',
          price: 5000,
          material_price: 1000,
          minutes: 30,
          description: 'description',
          flow_of_day: '',
          borrow_item: '',
          bring_your_own_item: '',
          extra_information: '',
          youtube_id: '',
          capacity: 1,
          additional_facility_fee: 0,
          category: 1,
          status: 'in_progress',
          kind: 'online',
          is_withholding_tax: false,
          recreation_profile_attributes: {
            profile_id: profile.id
          }
        }
      }
    end
    let(:expected) { RecreationSerializer.new.serialize(recreation: Recreation.last) }

    it_behaves_like 'an endpoint returns 2xx status', :expected

    context 'with valid params' do
      it_behaves_like 'an endpoint returns', :expected
    end

    context 'with invalid params' do
      let(:params) { { recreation: attributes_for(:recreation) } }
      it_behaves_like 'an endpoint returns 4xx status'
    end
  end

  describe 'PATCH /api_partner/recreations/:id' do
    let!(:profile) { create(:profile, user: current_user) }
    let!(:recreation) { create(:recreation, user: current_user) }
    let!(:relation) { create(:recreation_profile, recreation:, profile:) }
    let(:id) { recreation.id }
    let(:params) do
      {
        recreation: {
          title: 'title',
          second_title: 'second_title',
          price: 5000,
          material_price: 1000,
          minutes: 30,
          description: 'description',
          flow_of_day: '',
          borrow_item: '',
          bring_your_own_item: '',
          extra_information: '',
          youtube_id: '',
          capacity: 1,
          additional_facility_fee: 0,
          category: 1,
          status: 'in_progress',
          kind: 'online',
          is_withholding_tax: false,
          recreation_profile_attributes: {
            profile_id: profile.id
          }
        }
      }
    end
    let(:expected) { RecreationSerializer.new.serialize(recreation: recreation.reload) }

    it_behaves_like 'an endpoint returns', :expected

    context 'with valid params' do
      let(:params) { { recreation: { title: '' } } }

      it_behaves_like 'an endpoint returns 4xx status'
    end
  end
end
