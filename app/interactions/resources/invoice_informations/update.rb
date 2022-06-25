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
        invoice_information = InvoiceInformation.find_by(id: id, user_id: current_user.id)
        invoice_information.update!(params)
      rescue ActiveRecord::RecordInvalid => e
        errors.merge!(e.record.errors)
      end
    end
  end
end
