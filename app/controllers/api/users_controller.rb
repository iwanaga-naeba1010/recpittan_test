# frozen_string_literal: true

class Api::UsersController < Api::ApplicationController

  def self
    render_json UserSerializer.new.serialize(user: current_user)
  rescue StandardError => e
    logger.error e.message
    render_json([e.message], status: 401)
  end
end
