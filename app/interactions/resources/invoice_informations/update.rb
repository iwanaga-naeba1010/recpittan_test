# frozen_string_literal: true

module Resources
  module InvoiceInformations
    class Update < ActiveInteraction::Base

      hash :params do
        string :name
        string :zip
        string :prefecture
        string :city
        string :street
        string :building, default: nil
        string :code, default: nil
        string :memo, default: nil
      end

      integer :id
      object :current_user, class: User
      validates :current_user, presence: true

      def execute
        invoice_information = InvoiceInformation.find_by(id:, user_id: current_user.id)
        invoice_information.update!(params)
        invoice_information
      rescue ActiveRecord::RecordInvalid => e
        e.record.errors.errors.each do |error|
          errors.add(error.attribute, error.message)
        end
      end
    end
  end
end
