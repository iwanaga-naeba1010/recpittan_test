# frozen_string_literal: true

class Partners::RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]
  layout 'partner_registration'

  def new; end
end
