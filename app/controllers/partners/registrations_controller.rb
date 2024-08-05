# app/controllers/partners/registrations_controller.rb
# frozen_string_literal: true

class Partners::RegistrationsController < Partners::ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]
  skip_before_action :require_partner, only: %i[new]
  before_action :redirect_if_partner_logged_in, only: %i[new]
  before_action :store_location, only: %i[complete confirm]
  layout 'partner_registration'

  def new; end

  def complete; end

  def confirm; end

  private

  def redirect_if_partner_logged_in
    redirect_to root_path if current_user
  end

  def store_location
    store_location_for(:user, request.fullpath)
  end
end
