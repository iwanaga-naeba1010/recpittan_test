# frozen_string_literal: true

module ErrorHandlers
  extend ActiveSupport::Concern

  unless Rails.env.production?
    included do
      rescue_from Exception, with: :rescue500
      rescue_from ActionController::ActionControllerError, with: :rescue403
      rescue_from ActionController::RoutingError, with: :rescue404
      rescue_from ActiveRecord::RecordNotFound, with: :rescue404
    end
  end

  private

  def rescue403(error)
    @exception = error
    Rails.logger.error error.to_s
    render 'errors/forbidden', status: :forbidden
  end

  def rescue404(error)
    @exception = error
    Rails.logger.error error.to_s
    render 'errors/not_found', status: :not_found
  end

  def rescue500(error)
    @exception = error
    Rails.logger.error error.to_s
    render 'errors/internal_server_error', status: :internal_server_error
  end
end
