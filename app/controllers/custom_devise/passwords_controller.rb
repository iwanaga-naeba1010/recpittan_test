# frozen_string_literal: true

class CustomDevise::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # NOTE: best_practicesで引っかかるので一旦コメント
  # def after_sending_reset_password_instructions_path_for(_resource_name)
  #   new_user_session_path
  #   # super(resource_name)
  # end
end
