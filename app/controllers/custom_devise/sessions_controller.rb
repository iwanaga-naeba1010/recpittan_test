# frozen_string_literal: true

class CustomDevise::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  def after_sign_in_path_for(resource)
    stored_location = stored_location_for(resource)
    return stored_location unless stored_location.nil? || stored_location == root_path

    if resource.role.admin?
      admin_dashboard_path
    elsif resource.role.partner?
      partners_path(is_open: true)
    else
      session[:redirect_url] || customers_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
