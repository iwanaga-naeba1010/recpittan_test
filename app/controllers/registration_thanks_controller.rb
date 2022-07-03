# frozen_string_literal: true

class RegistrationThanksController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :require_path

  def index; end

  def require_path
    redirect_to root_path, alert: t('action_messages.unauthorized') unless request.referer&.include?(new_user_registration_path)
  end
end
