# frozen_string_literal: true

class Customers::ApplicationController < ApplicationController
  before_action :require_customer

  def require_customer
    # TODO: 管理画面にログアウトボタンを設置できないので、adminも許容
    redirect_to root_path, alert: t('action_messages.unauthorized') unless current_user&.role&.customer? || current_user&.role&.admin?
  end
end
