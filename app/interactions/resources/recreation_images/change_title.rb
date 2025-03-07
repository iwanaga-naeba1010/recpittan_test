# frozen_string_literal: true

module Resources
  module RecreationImages
    class ChangeTitle < ActiveInteraction::Base
      integer :recreation_image_id
      string :title
      validates :recreation_image_id, presence: true

      def execute
        image = RecreationImage.find(recreation_image_id)
        image.update(title: title)
      end
    end
  end
end
