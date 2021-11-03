# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :system do
  before do
    visit new_user_registration_path
  end

  context 'User' do
    feature 'password correct' do
      scenario 'succeeds' do
        input_text_boxes('#company_name', 'name')
        input_text_boxes('#company_facility_name', 'facility_name')
        input_text_boxes('#company_person_in_charge_name', 'person_in_charge_name')
        input_text_boxes('#company_person_in_charge_name_kana', 'person_in_charge_name_kana')
        input_text_boxes('#user_name', 'name')
        input_text_boxes('#user_email', 'test@gmail.com')
        input_text_boxes('#user_password', '11111111')
        input_text_boxes('#user_password_confirmation', '11111111')
        find('input[type="submit"]').click

        expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。'
        expect(page).to have_current_path root_path
      end
    end
  end
end
