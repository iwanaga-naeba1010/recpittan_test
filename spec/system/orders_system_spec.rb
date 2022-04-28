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

  context 'customers_orders_chat' do
    # NOTE(okubo): csrf-tokenがtestでなくなるので、下記で対応
    # https://qiita.com/kazutosato/items/b60fc9905e1adb83d9a4
    before do
      ActionController::Base.allow_forgery_protection = true
      visit chat_customers_order_path(order)
    end
    after do
      ActionController::Base.allow_forgery_protection = false
    end

    feature 'include Expenses value to orders' do
      scenario 'succeeds', js: true do
        puts '================'
        puts page.driver.browser.manage.logs.get(:browser)
        puts '================'
        page.find_by_id('OrderChat')
        page.find_by_id('editExpenses')
        find('#editExpenses').click
        input_text_boxes('#expenses', 10000)
        # sleep 1
        find('#submitExpenses').click
        sleep 5
        expect(find_by_id('resultExpenses')).to have_content '¥10,000'
      end
    end

#    feature 'include TransportationExpenses value to orders' do
#      scenario 'succeeds' do
#        click_labels '#editTransportationExpenses'
#        sleep 0.5
#        input_text_boxes('#transportationExpenses', 5000)
#        sleep 0.5
#        click_labels '#submitTransportationExpenses'
#        sleep 0.5
#        expect(find_by_id('resultTransportationExpenses')).to have_content '¥5,000'
#      end
#    end
#
#    feature 'include NumberOfCacilities value to orders' do
#      scenario 'succeeds' do
#        click_labels '#editNumberOfCacilities'
#        sleep 0.5
#        input_text_boxes('#numberOfFacilities', 3)
#        sleep 0.5
#        click_labels '#submitTransportationExpenses'
#        sleep 0.5
#        expect(find_by_id('resultExpenses')).to have_content '¥6,000'
#      end
#    end
#
#    feature 'open order modal' do
#      scenario 'succeeds' do
#        click_labels '#order-modal'
#        sleep 0.5
#        expect(find_by_id('orderModal')).to have_text('正式依頼フォーム')
#      end
#    end
#
#    feature 'open order modal' do
#      scenario 'succeeds' do
#        click_labels '#order-modal'
#        sleep 0.5
#        expect(find_by_id('orderModal')).to have_text('正式依頼フォーム')
#      end
#    end
  end
end
