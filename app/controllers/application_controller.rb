class ApplicationController < ActionController::Base
  before_action :set_default_url_options

  def set_default_url_options
    Rails.application.routes.default_url_options[:host] = request.host_with_port
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
