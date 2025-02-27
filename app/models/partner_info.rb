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
#  partner_infos_user_id_fkey  (user_id => users.id)
#
class PartnerInfo < ApplicationRecord
  belongs_to :user, class_name: 'User', inverse_of: :partner_info
end
