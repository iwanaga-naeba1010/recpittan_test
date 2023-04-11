# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customers::OnlineRecreationChannel', type: :system do
  let!(:customer) { create :user, :with_customer }
  let!(:online_recreation_channel) { create :online_recreation_channel, status: :public, period: Time.zone.today }
  let!(:channel_plan_subscriber) { create :channel_plan_subscriber, company: customer.company, status: :active }

  describe 'GET /customers/online_recreation_channels/:id' do
    context 'when next month channel exists' do
      let!(:online_recreation_channel2) { create :online_recreation_channel, status:, period: Time.zone.today + 1.month }
      before do
        sign_in customer
        visit customers_online_recreation_channel_path(online_recreation_channel.id)
      end

      context 'status is public' do
        let(:status) { :public }
        let(:expected_path) { customers_online_recreation_channel_path(online_recreation_channel2.id) }

        scenario 'succeeds' do
          expect(page).to have_content '来月のカレンダーはこちら'
          click_on('来月のカレンダーはこちら')
          sleep 3
          expect(page).to have_current_path(expected_path)
        end
      end

      context 'status is private' do
        let(:status) { :private }

        scenario 'succeeds' do
          expect(page).to_not have_content '来月のカレンダーはこちら'
        end
      end
    end

    context 'when next month public channel does not exist' do
      before do
        sign_in customer
        visit customers_online_recreation_channel_path(online_recreation_channel.id)
      end

      scenario 'succeeds' do
        expect(page).to_not have_content '来月のカレンダーはこちら'
      end
    end
  end
end
