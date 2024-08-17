# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/partners/recreations', type: :system do
  let(:partner) { create :user, :with_partner }
  let(:recreations) { partner.recreations }
  let(:recreation) { partner.recreations.first }
  let!(:recreation_image) { create(:recreation_image, recreation:) }
  let!(:recreation_prefecture) { create(:recreation_prefecture, recreation:) }
  let!(:recreation_profile) { create(:recreation_profile, recreation:) }

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
        expect(page).to have_content('金額・その他の情報を入力')

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

        expect(page).to have_current_path(partners_recreation_path(Recreation.last.id), ignore_query: true)

        partner.reload

        expect(partner.recreations.length).to eq 2
      end
    end
  end

  context 'Show Page' do
    before do
      ActionController::Base.allow_forgery_protection = true
      visit partners_recreations_path
    end
    after do
      ActionController::Base.allow_forgery_protection = false
    end

    feature 'Recreation show' do
      scenario 'succeeds', js: true do
        expect(page).to have_content('レクリエーション一覧')
        expect(page).to have_content(recreation.title)
        click_on(recreation.title, match: :first)
        expect(page).to have_current_path(partners_recreation_path(recreation))
      end
    end
  end

  context 'Edit Form' do
    before do
      ActionController::Base.allow_forgery_protection = true
      visit partners_recreation_path(recreation.id)
    end
    after do
      ActionController::Base.allow_forgery_protection = false
    end

    feature 'Recreation edit' do
      changed_title = 'changed title'

      scenario 'title form', js: true do
        expect(page).to have_content('レクリエーション詳細')
        expect(page).to have_content(recreation.title)
        click_on('レクの基本情報')
        expect(page).to have_current_path(edit_partners_recreation_path(recreation), ignore_query: true)
        expect(page).to have_content('レクの基本情報を入力')
        fill_in 'title', with: changed_title
        click_button('保存する')
        expect(page).to have_content 'レクを更新しました！'
        expect(page).to have_content(changed_title)
        expect(partner.recreations.first.title).to eq changed_title
      end

      scenario 'crate recreation_prefectures', js: true do
        expect(page).to have_content('レクリエーション詳細')
        expect(page).to have_content(recreation.title)
        click_on('レクの基本情報')
        expect(page).to have_current_path(edit_partners_recreation_path(recreation), ignore_query: true)
        click_on('＋複数エリアを追加')
        expect(recreation.recreation_prefectures.size).to eq 1
        sleep 5
        expect(recreation.recreation_prefectures.size).to eq 2
      end

      scenario 'delete recreation_prefectures', js: true do
        expect(page).to have_content('レクリエーション詳細')
        expect(page).to have_content(recreation.title)
        click_on('レクの基本情報')
        expect(page).to have_current_path(edit_partners_recreation_path(recreation), ignore_query: true)
        expect(recreation.recreation_prefectures.size).to eq 1
        click_button('削除')
        sleep 5
        expect(recreation.recreation_prefectures.size).to eq 0
      end

      scenario 'crate recreation_image', js: true do
        expect(page).to have_content('レクリエーション詳細')
        expect(page).to have_content(recreation.title)
        click_on('レク画像・関連ファイルのアップ')
        expect(page).to have_current_path(edit_partners_recreation_path(recreation), ignore_query: true)
        expect(recreation.recreation_images.size).to eq 1
        attach_file 'recreationImage', Rails.root.join('spec/files/test.png'), make_visible: true
        sleep 5
        expect(recreation.recreation_images.size).to eq 2
      end

      scenario 'delete recreation_image', js: true do
        expect(page).to have_content('レクリエーション詳細')
        expect(page).to have_content(recreation.title)
        click_on('レク画像・関連ファイルのアップ')
        expect(page).to have_current_path(edit_partners_recreation_path(recreation), ignore_query: true)
        expect(recreation.recreation_images.size).to eq 1
        click_button('削除')
        sleep 5
        expect(recreation.recreation_images.size).to eq 0
      end

      scenario 'crate recreation_profile', js: true do
        expect(page).to have_content('レクリエーション詳細')
        expect(page).to have_content(recreation.title)
        click_on('レク画像・関連ファイルのアップ')
        expect(page).to have_current_path(edit_partners_recreation_path(recreation), ignore_query: true)
        expect(recreation.recreation_profile.blank?)
        attach_file 'recreationProfile', Rails.root.join('spec/files/test.png'), make_visible: true
        sleep 5
        expect(recreation.recreation_profile.present?)
      end

      scenario 'delete recreation_profile', js: true do
        expect(page).to have_content('レクリエーション詳細')
        expect(page).to have_content(recreation.title)
        click_on('レク画像・関連ファイルのアップ')
        expect(page).to have_current_path(edit_partners_recreation_path(recreation), ignore_query: true)
        expect(recreation.recreation_profile.present?)
        click_button('削除')
        sleep 5
        expect(recreation.recreation_profile.blank?)
      end

      scenario 'profile form', js: true do
        expect(page).to have_content('レクリエーション詳細')
        expect(page).to have_content(recreation.title)
        click_on('レクに表示するプロフィール')
        expect(page).to have_current_path(edit_partners_recreation_path(recreation), ignore_query: true)
        expect(page).to have_content('プロフィールを選択')
        find("label[for='profileId0']").click
        click_button('保存する')
        expect(page).to have_content 'レクを更新しました！'
      end
    end
  end
end
