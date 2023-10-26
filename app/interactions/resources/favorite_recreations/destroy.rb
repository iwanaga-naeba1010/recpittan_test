# frozen_string_literal: true

module Resources
  module FavoriteRecreations
    class Destroy < ActiveInteraction::Base

      integer :favorite_recreation_id
      validates :favorite_recreation_id, presence: true

      def execute
        FavoriteRecreation.find(favorite_recreation_id).destroy
      end
    end
  end
end
