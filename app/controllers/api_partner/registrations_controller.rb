# frozen_string_literal: true

module ApiPartner
  class RegistrationsController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :require_partner, only: %i[create]

    def create
      @user = User.new(user_params)
      @user.id = User.last.id + 1
      @user.role = :partner
      @user.confirmed_at = Time.current

      if @user.save
        sign_in(@user)
        AfterConfirmationMailer.notify(user: @user).deliver_now
        render json: { message: 'Partner created and logged in successfully' }, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(
        :email, :password, :password_confirmation, :username, :username_kana,
        partner_info_attributes: %i[
          phone_number postal_code prefecture city address1 address2 company_name
        ]
      )
    end
  end
end
