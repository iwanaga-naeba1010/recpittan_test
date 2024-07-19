# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::RegistrationsController, type: :request do
  describe 'GET /partners/registrations/new' do
    context 'when partner is not logged in' do
      it_behaves_like 'an endpoint returns 2xx status'
    end

    context 'when partner is logged in' do
      include_context 'with authenticated partner'

      it_behaves_like 'an endpoint returns 3xx status'
    end
  end

  describe 'GET /partners/registrations/complete' do
    context 'when partner is logged in' do
      include_context 'with authenticated partner'

      it_behaves_like 'an endpoint returns 2xx status'
    end

    context 'when partner is not logged in' do
      it_behaves_like 'an endpoint returns 3xx status'
    end
  end

  describe 'GET /partners/recreations/confirm' do
    context 'when partner is logged in' do
      include_context 'with authenticated partner'

      it_behaves_like 'an endpoint returns 2xx status'
    end

    context 'when partner is not logged in' do
      it_behaves_like 'an endpoint returns 3xx status'
    end
  end
end
