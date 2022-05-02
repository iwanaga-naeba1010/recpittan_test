# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :system do
  let(:user) { create :user, :with_customer }
  let(:partner) { create :user, :with_recreations }
  let(:recreation) { partner.recreations.first }
  let(:order) { create :order, :with_order_dates, recreation_id: recreation.id, user_id: user.id }

  before do
    sign_in user
  end

  context 'OrderChat' do
    # NOTE(okubo): csrf-tokenがtestでなくなるので、下記で対応
    # https://qiita.com/kazutosato/items/b60fc9905e1adb83d9a4
    before do
      ActionController::Base.allow_forgery_protection = true
      visit chat_customers_order_path(order)
      # sleep 10
    end
    after do
      ActionController::Base.allow_forgery_protection = false
    end

    # TODO(okubo): reactのloadが完了していないことが問題ぽい。どこが問題かを調べる必要あり
    feature 'Recreation informatino' do
      scenario 'succeeds', js: true do
        # NOTE(okubo): 開催費
        expect(page).to have_content "¥#{order.price.to_s(:delimited)}"
        # NOTE(okubo): 材料費
        expect(page).to have_content "¥#{order.material_price.to_s(:delimited)}"
        # NOTE(okubo): 合計金額が表示されるか
        expect(page).to have_content "¥#{order.total_price_for_customer.to_s(:delimited)}"
      end
    end

    feature 'Expenses form' do
      scenario 'succeeds', js: true do
        page.find_by_id('OrderChat')
        find('#expensesEditButton').click
        input_text_boxes('#expensesInput', 10000)
        find('#expensesSubmitButton').click
        sleep 3

        order.reload
        expect(find_by_id('expenses')).to have_content '¥10,000'
        expect(page).to have_content "¥#{order.total_price_for_customer.to_s(:delimited)}"
      end
    end

    feature 'TranspotationExpenses form' do
      scenario 'succeeds', js: true do
        find('#transportationExpensesEditButton').click
        input_text_boxes('#transportationExpensesInput', 10000)
        find('#transportationExpensesSubmitButton').click
        sleep 3

        order.reload
        expect(find_by_id('transportationExpenses')).to have_content '¥10,000'
        expect(page).to have_content "¥#{order.total_price_for_customer.to_s(:delimited)}"
      end
    end

    feature 'NumberOfCacilities form' do
      scenario 'succeeds', js: true do
        puts '================'
        puts page.driver.browser.manage.logs.get(:browser)
        puts '================'
        page.find_by_id('OrderChat')

        find('#numberOfFacilitiesEditButton').click
        input_text_boxes('#numberOfFacilitiesInput', 5)
        find('#numberOfFacilitiesSubmitButton').click
        sleep 3

        order.reload
        expect(find_by_id('numberOfFacilities')).to have_content "¥#{order.additional_facility_fee * 5}"
        expect(page).to have_content "¥#{order.total_price_for_customer.to_s(:delimited)}"
      end
    end

    # TODO(okubo): chat送信のテスト追加
    # TODO(okubo): 正式依頼のテスト追加
  end
end
