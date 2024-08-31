# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resources::Recreations::Update, type: :interaction do
  describe '#execute' do
    let!(:partner) { create(:user, role: :partner) }
    let!(:profile) { create(:profile, user: partner) }
    let!(:recreation) { create(:recreation, user: partner, profile:) }
    let(:params) do
      {
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
        category: 'event',
        status: 'in_progress',
        kind: 'online'
      }
    end

    subject do
      Resources::Recreations::Update.run!(
        id: recreation.id,
        recreation_params: params,
        current_user: partner,
        profile_id: profile.id
      )
    end

    it 'should create a recreation' do
      expect { subject }
        .to change { Recreation.find(recreation.id).title }
        .from(recreation.title).to(params[:title])
    end

    context 'when prefectures are given' do
      let(:prefectures) { %w[北海道 青森県 岩手県] }

      subject do
        Resources::Recreations::Update.run!(
          id: recreation.id,
          recreation_params: params,
          current_user: partner,
          profile_id: profile.id,
          prefectures:
        )
      end

      context 'when new prefectures are added fron empty' do
        it 'should create prefectures' do
          expect { subject }
            .to change { recreation.recreation_prefectures.pluck(:name) }
            .from([])
            .to(%w[北海道 青森県 岩手県])
        end
      end

      context 'when new prefectures are added' do
        let!(:recreation_prefectures) do
          [
            create(:recreation_prefecture, recreation:, name: '北海道'),
            create(:recreation_prefecture, recreation:, name: '青森県')
          ]
        end

        it 'should create prefectures' do
          expect { subject }
            .to change { recreation.recreation_prefectures.pluck(:name) }
            .from(recreation_prefectures.pluck(:name))
            .to(%w[北海道 青森県 岩手県])
        end
      end

      context 'when some prefectures are removed' do
        let!(:recreation_prefectures) do
          [
            create(:recreation_prefecture, recreation:, name: '北海道'),
            create(:recreation_prefecture, recreation:, name: '青森県'),
            create(:recreation_prefecture, recreation:, name: '岩手県'),
            create(:recreation_prefecture, recreation:, name: '宮城県')
          ]
        end

        it 'should update prefectures' do
          expect { subject }
            .to change { recreation.recreation_prefectures.pluck(:name) }
            .from(recreation_prefectures.pluck(:name))
            .to(%w[北海道 青森県 岩手県])
        end
      end
    end
  end
end
