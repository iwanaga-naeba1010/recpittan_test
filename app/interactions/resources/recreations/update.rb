# frozen_string_literal: true

module Resources
  module Recreations
    class Update < ActiveInteraction::Base
      # NOTE(okubo): default:nilしている箇所は既存のrecreationでデータ不備がある場合を回避するため
      hash :recreation_params do
        string :title
        string :second_title
        integer :price
        # integer :amount
        integer :material_price, default: 0
        # integer :material_amount
        integer :minutes
        string :description, default: nil
        string :flow_of_day, default: nil
        string :borrow_item, default: nil
        string :bring_your_own_item, default: nil
        string :extra_information, default: nil
        string :youtube_id, default: nil
        integer :capacity, default: 0
        integer :additional_facility_fee, default: 0
        string :category
        string :kind
      end

      integer :id
      integer :profile_id
      object :current_user, class: User
      array :prefectures, default: nil

      validates :current_user, presence: true
      validates :profile_id, presence: true

      def execute
        ActiveRecord::Base.transaction do
          @recreation = current_user.recreations.find(id)
          changes = detect_changes(@recreation, recreation_params)
          @recreation.update!(recreation_params)
          update_profile_relation(profile_id:)
          update_prefectures(recreation_id: @recreation.id)

          notify_slack(@recreation, changes) if changes.any?
        end

        @recreation
      rescue ActiveRecord::RecordInvalid => e
        errors.merge!(e.record.errors)
      end

      private def update_recreation
        Recreation.update!(recreation_params)
      end

      private def update_profile_relation(profile_id:)
        @recreation.recreation_profile.update!(profile_id:)
      end

      # NOTE(okubo):ここは未対応
      private def update_prefectures(recreation_id:)
        return if prefectures.blank?

        RecreationPrefecture.create!(
          prefectures.map { |p| { name: p, recreation_id: } }
        )
      end

      private def detect_changes(recreation, params)
        changes = {}
        params.each do |key, value|
          original_value = recreation.send(key)
          changes[key] = { before: original_value, after: value } if original_value != value
        end
        changes
      end

      private def notify_slack(recreation, changes)
        message = <<~MESSAGE
          管理画面案件URL：#{Rails.application.routes.url_helpers.admin_recreation_path(recreation.id)}
          パートナー名: #{recreation.user_username}
          レク名: #{recreation.title}
          レクが更新されました。
          変更箇所:
          #{changes.map { |field, values| "#{I18n.t("activerecord.attributes.recreation.#{field}")}: #{values[:before]} -> #{values[:after]}" }.join("\n")}
        MESSAGE

        SlackNotifier.new(channel: '#product_confirmation_of_recreation').send('レク更新連絡', message)
      end
    end
  end
end
