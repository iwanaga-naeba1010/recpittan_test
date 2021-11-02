class Partners::ApplicationController < ApplicationController
  before_action :require_partner

  def require_partner
    redirect_to root_path, alert: '権限がありません' unless current_user&.role.partner?
  end
end
