# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/partners/recreations', type: :system do
  let(:partner) { create :user, :with_partner }

  before do
    sign_in partner
  end

  context 'New Form' do
    # NOTE(okubo): csrf-tokenがtestでなくなるので、下記で対応
    # https://qiita.com/kazutosato/items/b60fc9905e1adb83d9a4
    before do
      ActionController::Base.allow_forgery_protection = true
      visit new_partners_recreation_path
    end
    after do
      ActionController::Base.allow_forgery_protection = false
    end

    feature 'Recreation new form' do
      scenario 'succeeds', js: true do
        expect(page).to have_content('レクの基本情報を入力')
        find("label[for='kindonline']").click
        # page.check('#kindonline')
        select '30分', from: 'minutes'
        input_text_boxes('title', 'title')
        input_text_boxes('secondTitle', 'secondTitle')
        input_text_boxes('flowOfDay', 'flowOfDay')
        select '音楽', from: 'category'
        find("label[for='numberOfFacilitiesFalse']").click
        click_button('次へ')
        expect(page).to have_content('金額・メディア・その他の情報を入力')

        input_text_boxes('price', 10000)
        input_text_boxes('materialPrice', 2000)
        input_text_boxes('additionalFacilityFee', 1000)
        click_button('次へ')
        expect(page).to have_content('プロフィールを選択')

        find("label[for='profileId0']").click
        click_button('次へ')
        expect(page).to have_content('入力内容を確認')

        click_button('申請する')
        sleep 5

        expect(page).to have_current_path(partners_recreations_path)

        partner.reload

        expect(partner.recreations.length).to eq 2
      end
    end
  end
end
