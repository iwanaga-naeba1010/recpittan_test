# frozen_string_literal: true

class ApiPartner::RecreationsController < ApiPartner::ApplicationController
  before_action :set_recreation, only: %i[show update]

  def show
    render_json RecreationSerializer.new.serialize(recreation: @recreation)
  rescue StandardError => e
    logger.error e.message
    render_json([e.message], status: 422)
  end

  def create
    recreation = current_user.recreations.build(params_create)
    recreation.save!
    render_json RecreationSerializer.new.serialize(recreation: recreation)
  rescue StandardError => e
    logger.error e.message
    render_json([e.message], status: 422)
  end

  def update
    @recreation.update!(params_create)
    render_json RecreationSerializer.new.serialize(recreation: @recreation)
  rescue StandardError => e
    logger.error e.message
    render_json([e.message], status: 422)
  end

  # NOTE(okubo): configは予約後で使えない
  def config_data
    config = {
      categories: Recreation.category.values.map(&:text)
    }
    render_json config
  end

  private

  def set_recreation
    @recreation = current_user.recreations.find(params[:id])
  end

  def params_create
    params.require(:recreation).permit(
      %i[title second_title minutes is_online capacity category],
      recreation_profile_attributes: %i[profile_id] # NOTE(okubo): profileの中間テーブル作成
    )
  end
end
