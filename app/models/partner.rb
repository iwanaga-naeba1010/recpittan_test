# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  approval_status        :integer          default("unapproved")
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  memo                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("customer"), not null
#  sign_in_count          :integer          default(0), not null
#  title                  :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  username               :string
#  username_kana          :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :bigint
#
# Foreign Keys
#
#  users_company_id_fkey  (company_id => companies.id)
#
class Partner < User
  extend Enumerize

  # NOTE: 本来使うべきではないが、管理画面のためだけに使うので、ひとまず許容
  default_scope { where(role: :partner) }

  accepts_nested_attributes_for :partner_info, allow_destroy: true
  accepts_nested_attributes_for :bank_account, allow_destroy: true

  enumerize :manage_company_code, in: { EP: 0, WB: 1, RP: 2 }, default: 2
end
