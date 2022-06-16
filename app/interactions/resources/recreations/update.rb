# frozen_string_literal: true

module Resources
  module Recreations
    class Update < ActiveInteraction::Base

      hash :recreation_params do
        string :title
        string :second_title
        integer :price
        # integer :amount
        integer :material_price
        # integer :material_amount
        integer :minutes
        string :description
        string :flow_of_day
        string :borrow_item
        string :bring_your_own_item
        string :extra_information, default: nil
        string :youtube_id, default: nil
        integer :capacity
        integer :additional_facility_fee
        string :category
        string :status
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
          @recreation.update!(recreation_params)
          update_profile_relation(profile_id: profile_id)
          update_prefectures(recreation_id: @recreation.id)
        end

        @recreation
      rescue ActiveRecord::RecordInvalid => e
        errors.merge!(e.record.errors)
      end

      private def update_recreation
        Recreation.update!(recreation_params)
      end

      private def update_profile_relation(profile_id:)
        @recreation.recreation_profile.update!(profile_id: profile_id)
      end

      # NOTE(okubo):ここは未対応
      private def update_prefectures(recreation_id:)
        return if prefectures.blank?

        RecreationPrefecture.create!(
          prefectures.map { |p| { name: p, recreation_id: recreation_id } }
        )
      end
    end
  end
end
