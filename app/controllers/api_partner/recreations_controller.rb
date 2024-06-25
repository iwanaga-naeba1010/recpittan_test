# frozen_string_literal: true

module ApiPartner
  class RecreationsController < ApplicationController
    before_action :set_recreation, only: %i[show update]

    def index
      recreations = current_user.recreations.load_async
      render_json RecreationSerializer.new.serialize_list(recreations:)
    rescue StandardError => e
      logger.error e.message
      render_json([e.message], status: 401)
    end

    def show
      render_json RecreationSerializer.new.serialize(recreation: @recreation)
    rescue StandardError => e
      logger.error e.message
      render_json([e.message], status: 401)
    end

    def create
      recreation = Resources::Recreations::Create.run!(
        recreation_params: params_create.to_h,
        current_user:,
        profile_id: params_create.dig(:recreation_profile_attributes, :profile_id),
        prefectures: params_create[:recreation_prefectures_attributes]&.pluck(:name)
      )
      message = <<~MESSAGE
        管理画面案件URL：#{admin_recreation_url(recreation.id)}
        パートナー名: #{recreation.user_username}
        レク名: #{recreation.title}
        新規レク登録依頼を確認して、承認作業を行ってください。
      MESSAGE

      SlackNotifier
        .new(channel: '#product_confirmation_of_recreation')
        .send('新規レク登録依頼', message)
      render_json RecreationSerializer.new.serialize(recreation:)
    rescue StandardError => e
      logger.error e.message
      render_json([e.message], status: 422)
    end

    def update
      recreation = Resources::Recreations::Update.run!(
        id: params[:id].to_i,
        recreation_params: params_create.to_h,
        current_user:,
        profile_id: params_create.dig(:recreation_profile_attributes, :profile_id),
        prefectures: params_create[:recreation_prefectures_attributes]&.pluck(:name)
      )
      render_json RecreationSerializer.new.serialize(recreation:)
    rescue StandardError => e
      logger.error e.message
      render_json([e.message], status: 422)
    end

    # NOTE(okubo): configは予約後で使えない
    def config_data
      config = {
        categories: Recreation.category.values.map { |category| { name: category.text, enum_key: category } },
        minutes: [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60], # TODO(okubo): 後々綺麗にする
        prefectures: RecreationPrefecture.names,
        kind: Recreation.kind.values.map { |kind| { name: kind.text, enum_key: kind } }
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
        recreation_profile_attributes: %i[profile_id], # NOTE(okubo): profileの中間テーブル作成
        recreation_prefectures_attributes: %i[name]
      )
    end
  end
end
