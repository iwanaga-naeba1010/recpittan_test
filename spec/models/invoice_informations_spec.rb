# frozen_string_literal: true

# == Schema Information
#
# Table name: invoice_informations
#
#  id         :bigint           not null, primary key
#  building   :string
#  city       :string
#  code       :string
#  memo       :string
#  name       :string
#  prefecture :string
#  street     :string
#  zip        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe InvoiceInformation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
