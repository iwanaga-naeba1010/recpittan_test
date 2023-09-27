# frozen_string_literal: true

module Resources
  module FavoriteRecreations
    class Create < ActiveInteraction::Base

      integer :user_id
      integer :recreation_id

      validates :user_id, presence: true
      validates :recreation_id, presence: true

      def execute
        FavoriteRecreation.create!(user_id:, recreation_id:)
      end
    end
  end
end
