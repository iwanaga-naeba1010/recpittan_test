# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'BankAccounts', type: :request do
  include_context 'with authenticated admin'
  let!(:partner) { create :user, :with_partner }
  let!(:bank_account) { create :bank_account, user: partner }

  describe 'GET /admin/bank_accounts' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'GET /admin/bank_accounts/:id' do
    let!(:id) { bank_account.id }
    it_behaves_like 'an endpoint returns 2xx status'
  end
end
