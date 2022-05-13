# frozen_string_literal: true

module ApiPartner
  class RecreationsController < ApplicationController
    before_action :set_recreation, only: %i[show update]

    def show
      render_json RecreationSerializer.new.serialize(recreation: @recreation)
    rescue StandardError => e
      logger.error e.message
      render_json([e.message], status: 401)
    end

    def create
      # TODO(okubo): statusやkindが文字列で送られてくるが、それをAPIで保存できるか心配
      recreation = Resources::Recreations::Create.run!(
        recreation_params: params_create.to_h,
        current_user: current_user,
        profile_id: params_create.dig(:recreation_profile_attributes, :profile_id)
      )
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
        categories: Recreation.category.values.map { |category| { name: category.text, id: category.value } },
        minutes: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55], # TODO(okubo): 後々綺麗にする
        prefectures: RecreationPrefecture.names,
        kind: Recreation.kind.values.map { |kind| { name: kind.text, id: kind.value } }
      }
      render_json config
    end

    private def set_recreation
      @recreation = current_user.recreations.find(params[:id])
    end

    private def params_create
      params.require(:recreation).permit(
        %i[
          title second_title price material_price
          minutes description flow_of_day borrow_item bring_your_own_item extra_information
          youtube_id capacity category status kind additional_facility_fee
        ],
        recreation_profile_attributes: %i[profile_id] # NOTE(okubo): profileの中間テーブル作成
      )
    end
  end
end
