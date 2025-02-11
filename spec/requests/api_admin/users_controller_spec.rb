# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ApiAdmin::Users', type: :request do
  let(:admin) { create(:user, :with_admin) }
  let(:user) { create(:user, locked_at: Time.current, failed_attempts: Devise.maximum_attempts) }
  let(:non_lockable_user) { create(:user, locked_at: Time.current, failed_attempts: Devise.maximum_attempts - 1) }
  let(:unlocked_user) { create(:user, locked_at: nil) }

  before { sign_in admin }

  describe 'PATCH /api_admin/users/:id/unlock' do
    context 'when the user is locked' do
      before { patch unlock_api_admin_user_path(user.id) }

      it 'returns 200 OK' do
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body['message']).to eq('ユーザーのロックを解除しました')
      end

      it 'unlocks the user' do
        expect(user.reload.locked_at).to be_nil
        expect(user.reload.failed_attempts).to eq(0)
      end
    end

    context 'when the user is not locked' do
      before { patch unlock_api_admin_user_path(unlocked_user.id) }

      it 'returns 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['message']).to eq('ユーザーはロックされていません')
      end
    end

    context 'when the user is not unlockable' do
      before { patch unlock_api_admin_user_path(non_lockable_user.id) }

      it 'returns 422 Unprocessable Entity' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body['message']).to eq('このユーザーはunlockできません')
      end
    end

    context 'when the user does not exist' do
      before { patch unlock_api_admin_user_path(-1) }

      it 'returns 404 Not Found' do
        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body['error']).to eq('ユーザーが見つかりません')
      end
    end

    context 'when a non-admin user tries to unlock' do
      let(:non_admin) { create(:user, role: :customer) }

      before do
        sign_in non_admin
        patch unlock_api_admin_user_path(user.id)
      end

      it 'returns 401 Forbidden' do
        expect(response).to have_http_status(:unauthorized)
        expect(response.parsed_body.first).to eq('権限がありません')
      end
    end
  end
end
