# frozen_string_literal: true

module Resources
  module Recreations
    class Create < ActiveInteraction::Base

      hash :recreation_params do
        string :title
        string :second_title
        integer :price
        integer :material_price
        integer :minutes
        string :description
        string :flow_of_day
        string :borrow_item
        string :bring_your_own_item
        string :extra_information
        string :youtube_id
        integer :capacity
        integer :additional_facility_fee
        string :category
        string :status
        string :kind
      end

      object :current_user, class: User
      integer :profile_id
      array :prefectures, default: nil

      validates :current_user, presence: true
      validates :profile_id, presence: true

      def execute
        ActiveRecord::Base.transaction do
          @recreation = create_recreation
          create_profile_relation(recreation_id: @recreation.id)
          create_prefectures(recreation_id: @recreation.id)
        end

        @recreation
      rescue ActiveRecord::RecordInvalid => e
        errors.merge!(e.record.errors)
      end

      private def create_recreation
        next_id = Recreation.last&.id.to_i + 1
        Recreation.create!(recreation_params.merge(user_id: current_user.id, id: next_id))
      end

      private def create_profile_relation(recreation_id:)
        RecreationProfile.create!(recreation_id:, profile_id:)
      end

      private def create_prefectures(recreation_id:)
        return if prefectures.blank?

        RecreationPrefecture.create!(
          prefectures.map { |p| { name: p, recreation_id: } }
        )
      end
    end
  end
end
