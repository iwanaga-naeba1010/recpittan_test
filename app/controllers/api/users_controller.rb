# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    def self
      render_json UserSerializer.new.serialize(user: current_user)
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      render_json([e.message], status: 401)
    end
  end
end
