# frozen_string_literal: true

class ApiCustomer::ApplicationController < ApplicationController
  include JsonRenderable
  before_action :require_customer

  def require_customer
    return if current_user.role.customer?

    render_json(['権限がありません'], status: 401)
  end
end
