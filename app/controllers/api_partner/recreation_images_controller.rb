# frozen_string_literal: true

module ApiPartner
  class RecreationImagesController < ApplicationController
    def create
      image = Resources::RecreationImages::Create.run!(
        params: params_create,
        recreation_id: params[:recreation_id]
      )
      render_json RecreationImageSerializer.new.serialize(recreation_image: image)
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      render_json([e.message], status: 422)
    end

    def destroy
      Resources::RecreationImages::Destroy.run!(
        recreation_image_id: params[:id]
      )
      render_json true
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      render_json([e.message], status: 422)
    end

    private def params_create
      params.require(:recreation_image).permit(:image, :filename, :kind)
    end
  end
end
