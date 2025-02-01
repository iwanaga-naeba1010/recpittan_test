# frozen_string_literal: true

class ApiAdmin::UsersController < ApiAdmin::ApplicationController
  def unlock
    user = User.find_by(id: params[:id])

    unless user
      render json: { error: 'ユーザーが見つかりません' }, status: :not_found
      return
    end

    unless user.locked_at?
      render json: { message: 'ユーザーはロックされていません' }, status: :unprocessable_entity
      return
    end

    unless user.lockable?
      render json: { message: 'このユーザーはunlockできません' }, status: :unprocessable_entity
      return
    end

    user.unlock_user!

    render json: { message: 'ユーザーのロックを解除しました' }, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end
end
