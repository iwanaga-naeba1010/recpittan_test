# frozen_string_literal: true

class Partners::ApplicationController < ApplicationController
  layout 'partner'
  before_action :require_partner

  def require_partner
    redirect_to root_path, alert: t('action_messages.unauthorized') unless current_user&.role&.partner?
  end

  def redirect_if_partner_logged_in
    if current_user
      redirect_to root_path
    end
  end
end
