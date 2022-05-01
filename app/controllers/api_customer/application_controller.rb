# frozen_string_literal: true

module ApiCustomer
  class ApplicationController < ActionController::API
    include JsonRenderable
    before_action :authenticate_user!
    before_action :require_customer

    def set_default_url_options
      Rails.application.routes.default_url_options[:host] = request.host_with_port
      ActionMailer::Base.default_url_options[:host] = request.host_with_port
    end

    def require_customer
      return if current_user.role.customer?

      render_json(['権限がありません'], status: 401)
    end
  end
end
