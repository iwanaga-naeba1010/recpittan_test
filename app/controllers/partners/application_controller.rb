# frozen_string_literal: true

class Partners::ApplicationController < ApplicationController
  layout 'partner'
  before_action :require_partner

  # rubocop:disable Lint/SafeNavigationChain
  def require_partner
    redirect_to root_path, alert: '権限がありません' unless current_user&.role.partner?
  end
  # rubocop:enable Lint/SafeNavigationChain
end
