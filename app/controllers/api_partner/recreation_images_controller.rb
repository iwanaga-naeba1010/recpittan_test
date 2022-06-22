# frozen_string_literal: true

module ApiPartner
  class RecreationImagesController < ApplicationController
    before_action :set_recreation, only: %i[show create]

    # def index
    #   recreations = current_user.recreations
    #   render_json RecreationSerializer.new.serialize_list(recreations: recreations)
    # rescue StandardError => e
    #   logger.error e.message
    #   render_json([e.message], status: 401)
    # end
    #
    # def show
    #   render_json RecreationSerializer.new.serialize(recreation: @recreation)
    # rescue StandardError => e
    #   logger.error e.message
    #   render_json([e.message], status: 401)
    # end

    def create
      image = @recreation.recreation_images.build(params_create)
      image.save!

      render_json RecreationImageSerializer.new.serialize(image: image)
    rescue StandardError => e
      logger.error e.message
      render_json([e.message], status: 422)
    end

    private def set_recreation
      @recreation = current_user.recreations.find(params[:recreation_id])
    end

    private def params_create
      params.require(:recreation_image).permit(:image, :kind)
    end
  end
end
