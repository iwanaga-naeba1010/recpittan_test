# frozen_string_literal: true

module Resources
  module RecreationPrefectures
    class Destroy < ActiveInteraction::Base
      integer :recreation_prefecture_id
      validates :recreation_prefecture_id, presence: true

      def execute
        prefecture = RecreationPrefecture.find(recreation_prefecture_id)
        prefecture.destroy
      end
    end
  end
end
