# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', type: :system do
  before do
    sign_in user
  end

  context 'OrderChat with online recreation' do
    let(:user) { create :user, :with_customer }
    let(:partner) { create :user, :with_recreations }
    let(:recreation) { partner.recreations.first }
    let(:order) { create :order, :with_order_dates, recreation_id: recreation.id, user_id: user.id }

    # NOTE(okubo): csrf-tokenがtestでなくなるので、下記で対応
    # https://qiita.com/kazutosato/items/b60fc9905e1adb83d9a4
    before do
      ActionController::Base.allow_forgery_protection = true
      visit chat_customers_order_path(order)
    end
    after do
      ActionController::Base.allow_forgery_protection = false
    end

    feature 'Recreation informatino' do
      before do
        # NOTE(okubo): 数字が同じだとエラー出るのでダブらない数字
        order.update(expenses: 555, transportation_expenses: 666)
        order.reload
        visit chat_customers_order_path(order)
      end
      scenario 'succeeds', js: true do
        click_button('レクを正式依頼へ進む')
        sleep 3

        # NOTE(okubo): 開催費
        expect(page).to have_content("¥#{order.price.to_fs(:delimited)}", count: 2)
        # NOTE(okubo): 諸経費
        expect(page).to have_content("¥#{order.expenses.to_fs(:delimited)}", count: 2)
        # NOTE(okubo): 材料費
        expect(page).to have_content("¥#{order.material_price.to_fs(:delimited)}", count: 2)
        # NOTE(okubo): 合計金額が表示されるか
        expect(page).to have_content("¥#{order.total_price_for_customer.to_fs(:delimited)}", count: 2)
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
        expect(page).to have_content "¥#{order.total_price_for_customer.to_fs(:delimited)}"
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
        expect(find_by_id('numberOfFacilities')).to have_content "¥#{(order.additional_facility_fee * 5).to_fs(:delimited)}"
        expect(page).to have_content "¥#{order.total_price_for_customer.to_fs(:delimited)}"
      end
    end

    feature 'Chat form' do
      scenario 'succeeds', js: true do
        text = '送信テキスト'

        find('#numberOfFacilitiesEditButton').click
        input_text_boxes('#chatInput', text)
        find('#chatSubmit').click
        sleep 3

        order.reload
        expect(page).to have_content text
      end

      scenario 'failures', js: true do
        text = ''
        find('#numberOfFacilitiesEditButton').click
        input_text_boxes('#chatInput', text)
        find('#chatSubmit').click
        sleep 3

        order.reload
        expect(page).to have_content 'バリデーションに失敗しました: Chatsは不正な値です'
      end
    end

    feature 'Order form' do
      before do
        order.update(expenses: 5555, number_of_facilities: 2, number_of_people: 5)
        order.reload
      end
      scenario 'succeeds', js: true do
        page.find_by_id('OrderChat')

        click_button('レクを正式依頼へ進む')
        sleep 5

        select '2023', from: 'year'
        select '6', from: 'month'
        select '1', from: 'day'
        select '10', from: 'startHour'
        select '00', from: 'startMinute'
        select '11', from: 'endHour'
        select '00', from: 'endMinute'

        fill_in 'zip', with: '4536111'

        # NOTE(okubo): 通信が遅れる可能性が高いのであえて長めの時間を設定
        find('#searchAddressWithZipForOrder').click
        sleep 10

        click_button('パートナーにレク開催を正式依頼する')

        sleep 3
        expect(page).to have_current_path(complete_customers_order_path(order))
      end
    end
  end

  context 'OrderChat with visit receration' do
    let(:user) { create :user, :with_customer }
    let(:partner) { create :user, :with_partner }
    let(:recreation) { partner.recreations.first }
    let(:order) { create :order, :with_order_dates, recreation_id: recreation.id, user_id: user.id }

    # NOTE(okubo): csrf-tokenがtestでなくなるので、下記で対応
    # https://qiita.com/kazutosato/items/b60fc9905e1adb83d9a4
    before do
      ActionController::Base.allow_forgery_protection = true
      visit chat_customers_order_path(order)
    end
    after do
      ActionController::Base.allow_forgery_protection = false
    end

    feature 'Recreation informatino' do
      before do
        # NOTE(okubo): 数字が同じだとエラー出るのでダブらない数字
        order.update(expenses: 555, transportation_expenses: 666)
        order.reload
        visit chat_customers_order_path(order)
      end
      scenario 'succeeds', js: true do
        click_button('レクを正式依頼へ進む')
        sleep 3

        # NOTE(okubo): 開催費
        expect(page).to have_content("¥#{order.price.to_fs(:delimited)}", count: 2)
        # NOTE(okubo): 交通費
        expect(page).to have_content("¥#{order.transportation_expenses.to_fs(:delimited)}", count: 2)
        # NOTE(okubo): 諸経費
        expect(page).to have_content("¥#{order.expenses.to_fs(:delimited)}", count: 2)
        # NOTE(okubo): 材料費
        expect(page).to have_content("¥#{order.material_price.to_fs(:delimited)}", count: 2)
        # NOTE(okubo): 合計金額が表示されるか
        expect(page).to have_content("¥#{order.total_price_for_customer.to_fs(:delimited)}", count: 2)
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
        expect(page).to have_content "¥#{order.total_price_for_customer.to_fs(:delimited)}"
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
        expect(page).to have_content "¥#{order.total_price_for_customer.to_fs(:delimited)}"
      end
    end

    feature 'NumberOfCacilities form' do
      scenario 'succeeds', js: true do
        puts '================'
        puts page.driver.browser.manage.logs.get(:browser)
        puts '================'
        page.find_by_id('OrderChat')
        sleep 3

        order.reload
        # expect(find_by_id('numberOfFacilities')).to have_content "¥#{(order.additional_facility_fee * 5).to_s(:delimited)}"
        expect(page).to have_content "¥#{order.total_price_for_customer.to_fs(:delimited)}"
      end
    end

    feature 'Order form' do
      before do
        order.update(expenses: 5555, transportation_expenses: 6666, number_of_people: 5)
        order.reload
      end
      scenario 'succeeds', js: true do
        page.find_by_id('OrderChat')

        click_button('レクを正式依頼へ進む')
        sleep 5

        select '2023', from: 'year'
        select '6', from: 'month'
        select '1', from: 'day'
        select '10', from: 'startHour'
        select '00', from: 'startMinute'
        select '11', from: 'endHour'
        select '00', from: 'endMinute'

        fill_in 'zip', with: '4536111'

        # NOTE(okubo): 通信が遅れる可能性が高いのであえて長めの時間を設定
        find('#searchAddressWithZipForOrder').click
        sleep 10

        click_button('パートナーにレク開催を正式依頼する')

        sleep 3
        expect(page).to have_current_path(complete_customers_order_path(order))
      end
    end
  end
end
