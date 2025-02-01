# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :system do
  before do
    visit new_user_registration_path
  end

  context 'User' do
    feature 'password correct' do
      scenario 'succeeds' do
        input = {
          user: {
            email: 'test@gmail.com',
            password: 'Aa1!aaaa'
          },
          company: {
            name: 'name',
            facility_name: 'facility_name',
            person_in_charge_name: 'person_in_charge_name',
            person_in_charge_name_kana: 'person_in_charge_name_kana',
            genre: 'その他',
            prefecture: '東京都'
          }
        }

        input_text_boxes('#user_company_attributes_name', input[:company][:name])
        input_text_boxes('#user_company_attributes_facility_name', input[:company][:facility_name])
        input_text_boxes('#user_company_attributes_person_in_charge_name', input[:company][:person_in_charge_name])
        input_text_boxes('#user_company_attributes_person_in_charge_name_kana', input[:company][:person_in_charge_name_kana])
        select(input[:company][:genre], from: 'user_company_attributes_genre')
        select(input[:company][:prefecture], from: 'user_company_attributes_prefecture')

        input_text_boxes('#user_email', input[:user][:email])
        input_text_boxes('#user_password', input[:user][:password])
        input_text_boxes('#user_password_confirmation', input[:user][:password])
        click_button '登録'

        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'

        expect(page).to have_current_path registration_thanks_path

        sleep 3
        user = User.last
        company = user.company

        expect(user.email).to eq input[:user][:email]
        expect(company.name).to eq input[:company][:name]
        expect(company.facility_name).to eq input[:company][:facility_name]
        expect(company.person_in_charge_name).to eq input[:company][:person_in_charge_name]
        expect(company.person_in_charge_name_kana).to eq input[:company][:person_in_charge_name_kana]
      end
    end
  end
end
