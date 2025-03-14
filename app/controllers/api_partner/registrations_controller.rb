# frozen_string_literal: true

module ApiPartner
  class RegistrationsController < ApplicationController
    skip_before_action :authenticate_user!
    skip_before_action :require_partner, only: %i[create]

    def create
      @user = User.new(user_params)
      @user.role = :partner
      @user.confirmed_at = Time.current

      @user.save!
      sign_in(@user)
      AfterRegistrationPartnerMailer.notify(user: @user).deliver_now
      render json: { message: 'Partner created and logged in successfully' }, status: :created
    rescue ActiveRecord::RecordInvalid => e
      Sentry.capture_exception(e)
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
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
