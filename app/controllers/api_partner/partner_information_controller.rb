# frozen_string_literal: true

module ApiPartner
  class PartnerInformationController < ApplicationController
    before_action :set_user, only: %i[show update]

    def show
      render json: PartnerSerializer.new.serialize(partner: @user)
    end

    def update
      if @user.update(user_params)
        render json: { message: 'User information updated successfully' }, status: :ok
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :username, :username_kana,
        partner_info_attributes: %i[
          phone_number postal_code prefecture city address1 address2 company_name
        ]
      )
    end
  end
end
