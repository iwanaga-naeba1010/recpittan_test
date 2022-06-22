# frozen_string_literal: true

module Resources
  module InvoiceInformation
    class Create < ActiveInteraction::Base

      hash :invoice_information_params do
        string :name
        string :code
        string :memo
        string :zip
        string :prefectures
        string :city
        string :street
        string :building
      end

      object :current_user, class: User

      validates :current_user, presence: true

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
        InvoiceInformation.create!(recreation_params.merge(user_id: current_user.id))
      end
    end
  end
end
