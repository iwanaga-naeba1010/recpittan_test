# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_informations
#
#  id           :bigint           not null, primary key
#  building     :string
#  city         :string           not null
#  code         :string
#  company_name :string           not null
#  email        :string           not null
#  memo         :string
#  name         :string           not null
#  prefecture   :string           not null
#  street       :string           not null
#  zip          :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_invoice_informations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class InvoiceInformation < ApplicationRecord
  include Ransackable

  belongs_to :user, class_name: 'User'

  validates :company_name, :name, :email, :zip, :prefecture, :city, :street, presence: true
end
