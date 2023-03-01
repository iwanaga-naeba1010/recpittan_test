# frozen_string_literal: true

module Resources
  module RecreationPrefectures
    class Create < ActiveInteraction::Base
      hash :params do
        string :name
      end
      integer :recreation_id
      validates :recreation_id, presence: true

      def execute
        ActiveRecord::Base.transaction do
          prefecture = RecreationPrefecture.new(
            recreation_id:,
            name: params[:name]
          )
          prefecture.save!
          prefecture
        end
      rescue ActiveRecord::RecordInvalid => e
        errors.merge!(e.record.errors)
      end
    end
  end
end
