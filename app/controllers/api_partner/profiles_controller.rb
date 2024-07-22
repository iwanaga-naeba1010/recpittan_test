# frozen_string_literal: true

module ApiPartner
  class ProfilesController < ApplicationController
    def index
      profiles = current_user.profiles.load_async
      render_json ProfileSerializer.new.serialize_list(profiles:)
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      render_json([e.message], status: 422)
    end
  end
end
