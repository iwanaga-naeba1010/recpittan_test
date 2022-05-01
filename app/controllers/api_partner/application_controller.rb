# frozen_string_literal: true

module ApiPartner
  class ApplicationController < ActionController::API
    include JsonRenderable
    before_action :authenticate_user!
    before_action :require_partner

    def set_default_url_options
      Rails.application.routes.default_url_options[:host] = request.host_with_port
      ActionMailer::Base.default_url_options[:host] = request.host_with_port
    end

    def require_partner
      return if current_user.role.partner?

      render_json(['権限がありません'], status: 401)
    end
  end
end
