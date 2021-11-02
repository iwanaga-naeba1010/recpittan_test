class Customers::ApplicationController < ApplicationController
  before_action :require_customer

  def require_customer
    redirect_to root_path, alert: '権限がありません' unless current_user&.role.customer?
  end
end
