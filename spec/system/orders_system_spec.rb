# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :system do
  let(:user) { create :user, :with_custoemr }
  let(:partner) { create :user, :with_recreations }
  let(:recreation) { partner.recreations.first }
  let(:order) { create :order, :with_order_dates, recreation_id: recreation.id, user_id: user.id }

  before do
    sign_in user
  end

  context 'customers_orders_chat', js: true do
    before do
      visit chat_customers_order_path(order)
    end

    feature 'include Expenses value to orders' do
      scenario 'succeeds' do
        click_labels '#editExpenses'
        sleep 0.5
        input_text_boxes('#expenses', 10000)
        sleep 0.5
        click_labels '#submitExpenses'
        sleep 0.5
        expect('#resultExpenses').to have_content '¥10,000'
      end
    end

    feature 'include TransportationExpenses value to orders' do
      scenario 'succeeds' do
        click_labels '#editTransportationExpenses'
        sleep 0.5
        input_text_boxes('#transportationExpenses', 5000)
        sleep 0.5
        click_labels '#submitTransportationExpenses'
        sleep 0.5
        expect('#resultExpenses').to have_content '¥5,000'
      end
    end

    feature 'include NumberOfCacilities value to orders' do
      scenario 'succeeds' do
        click_labels '#editNumberOfCacilities'
        sleep 0.5
        input_text_boxes('#numberOfFacilities', 3)
        sleep 0.5
        click_labels '#submitTransportationExpenses'
        sleep 0.5
        expect('#resultExpenses').to have_content '¥6,000'
      end
    end

    feature 'open order modal' do
      scenario 'succeeds' do
        click_labels '#order-modal'
        sleep 0.5
        expect(find_by_id('orderModal')).to have_text('正式依頼フォーム')
      end
    end
  end
end
