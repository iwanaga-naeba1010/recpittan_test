# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_default_url_options
  before_action :authenticate_user!

  def set_default_url_options
    Rails.application.routes.default_url_options[:host] = request.host_with_port
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  # active adminをUserでログインするために必要
  # NOTE: best_practicesで引っかかるので一旦コメント
  def authenticate_admin!
    if ENV['BASIC_AUTH']
      user, password = ENV['BASIC_AUTH'].split(',').map(&:strip)
      authenticate_or_request_with_http_basic('basic auth') do |input_user, input_pass|
        input_user == user && Digest::SHA1.hexdigest(input_pass) == password
      end
    end

    redirect_to new_user_session_path unless current_user.role.admin? || current_user.role.cs?
  end
end
