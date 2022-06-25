# frozen_string_literal: true

module Resources
  module InvoiceInformations
    class Create < ActiveInteraction::Base
      hash :params do
        string :name
        string :zip
        string :prefecture
        string :city
        string :street
        string :building, default: nil
        string :memo, default: nil
      end

      object :current_user, class: User
      validates :current_user, presence: true

      def execute
        invoice_information = current_user.build_invoice_information(params)
        invoice_information.save!
      rescue ActiveRecord::RecordInvalid => e
        errors.merge!(e.record.errors)
      end
    end
  end
end
