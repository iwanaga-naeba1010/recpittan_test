# frozen_string_literal: true

module ApiPartner
  class RecreationPrefecturesController < ApplicationController
    def create
      prefecture = Resources::RecreationPrefectures::Create.run!(
        params: params_create,
        recreation_id: params[:recreation_id]
      )
      render_json RecreationPrefectureSerializer.new.serialize(recreation_prefecture: prefecture)
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      render_json([e.message], status: 422)
    end

    def update
      prefecture = Resources::RecreationPrefectures::Update.run!(
        id: params[:id],
        params: params_create,
        recreation_id: params[:recreation_id]
      )
      render_json RecreationPrefectureSerializer.new.serialize(recreation_prefecture: prefecture)
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      render_json([e.message], status: 422)
    end

    def destroy
      Resources::RecreationPrefectures::Destroy.run!(
        recreation_prefecture_id: params[:id]
      )
      render_json true
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      render_json([e.message], status: 422)
    end

    private def params_create
      params.require(:recreation_prefecture).permit(:name)
    end
  end
end
