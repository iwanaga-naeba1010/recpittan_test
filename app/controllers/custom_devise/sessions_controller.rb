# app/controllers/custom_devise/sessions_controller.rb
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
    return admin_dashboard_path if resource.role.admin? && (stored_location.nil? || stored_location == root_path)
    return partners_path(is_open: true) if resource.role.partner? && (stored_location.nil? || stored_location == root_path)

    stored_location || session[:redirect_url] || customers_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
