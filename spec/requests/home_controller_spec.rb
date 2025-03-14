# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :request do
  describe 'GET /index' do
    it 'return http success' do
      get home_index_path
      expect(response).to have_http_status(:ok)
    end
  end
end
