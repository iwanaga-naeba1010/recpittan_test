# frozen_string_literal: true

module Resources
  module InvoiceInformations
    class Create < ActiveInteraction::Base
      hash :params do
        string :company_name
        string :name
        string :email
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
        invoice_information
      rescue ActiveRecord::RecordInvalid => e
        # TODO(okubo): e.record.errors.errorsのattributeで判断つきそうだけど、なぜかbaseになる
        e.record.errors.errors.each do |error|
          errors.add(error.attribute, error.message)
        end
      end
    end
  end
end
