# frozen_string_literal: true

module Resources
  module InvoiceInformations
    class Update < ActiveInteraction::Base

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

      integer :id
      object :current_user, class: User

      validates :current_user, presence: true

      def execute
        ActiveRecord::Base.transaction do
          @invoice_information = current_user.invoice_information.id
          @invoice_information.update!(invoice_information_params)
        end

        @invoice_information
      rescue ActiveRecord::RecordInvalid => e
        errors.merge!(e.record.errors)
      end

      private def update_invoice_information
        InvoiceInformation.update!(invoice_information_params)
      end
    end
  end
end
