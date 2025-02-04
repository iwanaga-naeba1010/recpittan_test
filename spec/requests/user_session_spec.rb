require 'rails_helper'

RSpec.describe 'User Session Timeout', type: :request do
  let(:user) { create(:user) }

  it 'logs out user after session timeout' do
    sign_in user
    get root_path
    expect(response).to be_successful

    travel 25.hours do
      get root_path
      follow_redirect!
      expect(response.body).to include('ログイン')
    end
  end
end
