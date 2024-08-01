# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ErrorHandlers
  before_action :set_default_url_options
  before_action :authenticate_user!
  before_action :set_query_flash
  after_action  :store_redirect_url

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

  # NOTE: ログイン後に直前のページへリダイレクトさせるために必要
  def store_redirect_url
    if request.fullpath != '/users/sign_in' &&
       request.fullpath != '/users/sign_up' &&
       request.fullpath !~ Regexp.new('\\A/users/password.*\\z') &&
       !request.xhr?

      session[:redirect_url] = request.fullpath
    end
  end

  # ログイン後にリダイレクトするための場所を保存
  def store_location_for(resource_or_scope, location)
    session_key = Devise::Mapping.find_scope!(resource_or_scope).to_s
    session["#{session_key}_return_to"] = location
  end

  # NOTE(okubo): 主にreactからflashを与えるための目的で設置
  private def set_query_flash
    flash[:notice] = params[:notice] if params[:notice]
    flash.now[:alert] = params[:alert] if params[:alert]
  end
end
