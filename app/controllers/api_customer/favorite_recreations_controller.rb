# frozen_string_literal: true

module ApiCustomer
  class FavoriteRecreationsController < ApplicationController
    def index
      favorite_recreations = current_user.favorite_recreations
      render_json FavoriteRecreationSerializer.new.serialize_list(favorite_recreations:)
    end

    def show
      favorite_recreation = current_user.favorite_recreations.find_by(recreation_id: params[:id])
      return render_json FavoriteRecreationSerializer.new.serialize(favorite_recreation:) if favorite_recreation

      render_json({ is_favorite: false })
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      render_json([e.message], status: 422)
    end

    def create
      favorite_recreation = Resources::FavoriteRecreations::Create.run!(
        user_id: current_user.id,
        recreation_id: params_create[:recreation_id]
      )
      render_json FavoriteRecreationSerializer.new.serialize(favorite_recreation:)
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      render_json([e.message], status: 422)
    end

    def destroy
      Resources::FavoriteRecreations::Destroy.run!(
        favorite_recreation_id: params[:id]
      )
      render_json true
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      render_json([e.message], status: 422)
    end

    private def params_create
      params.require(:favorite_recreation).permit(:user_id, :recreation_id)
    end
  end
end
