# frozen_string_literal: true

class Partners::RegistrationsController < Partners::ApplicationController
  skip_before_action :authenticate_user!, only: %i[new]
  skip_before_action :require_partner, only: %i[new]
  before_action :redirect_if_partner_logged_in, only: %i[new]
  layout 'partner_registration'

  def new; end

  def complete; end

  def confirm; end
end
