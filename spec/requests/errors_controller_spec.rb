# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ErrorsController, type: :request do
  describe 'GET /404_route' do
    it 'renders 404 page' do
      get '/404_route'
      expect(response).to have_http_status(:not_found)
      expect(response).to render_template('errors/not_found')
    end
  end

  # TODO: 500のテストも追加する
  # controller do
  #   def routing_error
  #     raise StandardError
  #   end
  # end
  # describe 'GET /500_route' do
  #   it 'renders 500 page' do
  #     get root_path
  #     expect(response).to have_http_status(:internal_server_error)
  #     expect(response).to render_template('errors/internal_server_error')
  #   end
  # end
end
