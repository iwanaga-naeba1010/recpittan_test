# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FinalCheckMails', type: :request do
  include_context 'with authenticated admin'

  describe 'GET /admin/final_check_mails' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/final_check_mails' do
    let(:params) do
      {  }
    end
    let(:expected_redirect_to) { %r{/admin/final_check_mails} }

    it_behaves_like 'an endpoint redirects match'
  end
end
