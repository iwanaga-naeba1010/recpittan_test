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
#  pref_code    :string
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
class PartnerInfoSerializer
  def serialize(partner_info:)
    {
      id: partner_info.id,
      phone_number: partner_info.phone_number,
      postal_code: partner_info.postal_code,
      prefecture: partner_info.prefecture,
      city: partner_info.city,
      address1: partner_info.address1,
      address2: partner_info.address2,
      company_name: partner_info.company_name
    }
  end
end
