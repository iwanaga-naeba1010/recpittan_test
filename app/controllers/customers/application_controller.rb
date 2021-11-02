class Customers::ApplicationController < ApplicationController
  before_action :require_customer

  def require_customer
    # TODO: 管理画面にログアウトボタンを設置できないので、adminも許容
    redirect_to root_path, alert: '権限がありません' unless current_user&.role.customer? || current_user&.role.admin?
  end
end
