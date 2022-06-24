# frozen_string_literal: true

module Resources
  module RecreationImages
    class Destroy < ActiveInteraction::Base
      integer :recreation_image_id
      validates :recreation_image_id, presence: true

      def execute
        image = RecreationImage.find(recreation_image_id)
        image.destroy
      end
    end
  end
end

