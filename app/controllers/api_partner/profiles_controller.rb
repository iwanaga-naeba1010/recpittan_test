# frozen_string_literal: true

class ApiPartner::ProfilesController < ApiPartner::ApplicationController
  def index
    profiles = current_user.profiles
    render_json ProfileSerializer.new.serialize_list(profiles: profiles)
  rescue StandardError => e
    logger.error e.message
    render_json([e.message], status: 422)
  end
end
