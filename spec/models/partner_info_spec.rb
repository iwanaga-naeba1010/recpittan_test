# frozen_string_literal: true

# == Schema Information
#
# Table name: partner_infos
#
#  id           :bigint           not null, primary key
#  address1     :string
#  address2     :string
#  city         :string
#  company_name :string
#  phone_number :string
#  postal_code  :string
#  prefecture   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_partner_infos_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe PartnerInfo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
