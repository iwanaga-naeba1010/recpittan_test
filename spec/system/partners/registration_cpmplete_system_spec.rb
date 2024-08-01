# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RegistrationComplete', type: :system do
  let(:partner) { create :user, :with_partner }

  context 'User' do
    feature 'redirect_to new_user_session_path' do
      scenario 'succeeds' do
        visit complete_partners_registrations_path
        expect(page).to have_current_path new_user_session_path
      end
    end

    feature 'redirect_to confirm_partners_registrations_path after login' do
      scenario 'succeeds' do
        visit complete_partners_registrations_path

        input_text_boxes('#user_email', partner.email)
        input_text_boxes('#user_password', partner.password)
        input_text_boxes('#user_password_confirmation', partner.password)

        click_button 'ログイン'
        sleep 3
        expect(page).to have_current_path complete_partners_registrations_path
      end
    end
  end
end
