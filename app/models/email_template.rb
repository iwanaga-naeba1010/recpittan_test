# frozen_string_literal: true

# == Schema Information
#
# Table name: email_templates
#
#  id          :bigint           not null, primary key
#  body        :text
#  explanation :string
#  kind        :integer
#  signature   :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class EmailTemplate < ApplicationRecord
  extend Enumerize
  enumerize :kind, in: {
    customer_email_authenticatin: 0, customer_password_change: 1, customer_chat_start: 2, customer_chat: 3, order_accept: 4,
    order_deny: 5, customer_complete_report: 6, partner_email_authenticatin: 7, partner_password_change: 8, partner_chat_start: 9,
    partner_chat: 10, order_request: 11, report_deny: 12, report_accept: 13, partner_complete_report: 14,
    after_confirmation: 15, final_check: 16
  }, default: 0
end
