# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customers::RedirectAfterSignIn', type: :system do
  let(:customer) { create :user, :with_customer }
  let(:partner) { create :user, :with_recreations }
  let(:recreation) { partner.recreations.first }
  let(:redirect_url) { customers_recreation_path(recreation) }

  context 'New Form' do
    before do
      visit redirect_url
    end

    feature 'redirect to stored url' do
      scenario 'succeeds' do
        click_on('ログインして相談・依頼する')
        expect(page).to have_current_path(new_user_session_path)
        fill_in 'user_email', with: customer.email
        fill_in 'user_password', with: 'Aa1!aaaa'
        click_button('ログイン')
        sleep 3
        expect(page).to have_current_path(redirect_url)
      end
    end
  end
end
