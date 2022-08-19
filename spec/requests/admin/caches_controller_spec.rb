# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Caches', type: :request do
  include_context 'with authenticated admin'

  describe 'GET /admin/caches' do
    it_behaves_like 'an endpoint returns 2xx status'
  end

  describe 'POST /admin/caches' do
    let(:params) do
      {}
    end
    let(:expected_redirect_to) { %r{/admin/caches} }

    it_behaves_like 'an endpoint redirects match'
  end
end
