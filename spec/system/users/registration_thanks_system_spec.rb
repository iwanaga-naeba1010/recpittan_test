# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RegistrationThanks', type: :system do
  before do
    visit new_user_registration_path
  end

  context 'User' do
    feature 'redirect_to root_path' do
      scenario 'succeeds' do
        visit registration_thanks_path
        expect(page).to have_current_path root_path
        expect(page).to have_content I18n.t('action_messages.unauthorized')
      end
    end
  end
end
