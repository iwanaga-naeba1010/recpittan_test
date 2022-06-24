# frozen_string_literal: true

module ApiPartner
  class RecreationImagesController < ApplicationController
    # before_action :set_recreation, only: %i[show create]

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

    # TODO(okubo): base64をエンコードする必要あり
    # https://blog.hello-world.jp.net/posts/ruby-2281
    def create
      image = Resources::RecreationImages::Create.run!(
        params: params_create,
        recreation_id: params[:recreation_id]
      )

      render_json RecreationImageSerializer.new.serialize(recreation_image: image)
    rescue StandardError => e
      logger.error e.message
      render_json([e.message], status: 422)
    end

    private def params_create
      params.require(:recreation_image).permit(:image, :kind)
    end
  end
end
