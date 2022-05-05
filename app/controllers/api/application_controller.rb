# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::API
    include JsonRenderable
    before_action :set_default_url_options
    before_action :authenticate_user!

    def set_default_url_options
      Rails.application.routes.default_url_options[:host] = request.host_with_port
      ActionMailer::Base.default_url_options[:host] = request.host_with_port
    end
  end
end
