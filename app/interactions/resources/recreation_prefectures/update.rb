# frozen_string_literal: true

module Resources
  module RecreationPrefectures
    class Update < ActiveInteraction::Base
      hash :params do
        string :name
      end

      integer :id
      integer :recreation_id

      validates :id, :recreation_id, :params, presence: true
      validate :validate_params

      def execute
        prefecture = RecreationPrefecture.find_by(
          id: id,
          recreation_id: recreation_id
        )
        ActiveRecord::Base.transaction do
          prefecture.update!(name: params[:name])
          prefecture
        end
      rescue ActiveRecord::RecordInvalid => e
        errors.merge!(e.record.errors)
      end

      private def validate_params
        return if params[:name].present?

        errors.add(:name, '都道府県名は必須です')
      end
    end
  end
end
