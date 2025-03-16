# frozen_string_literal: true

# == Schema Information
#
# Table name: system_parameters
#
#  id           :bigint           not null, primary key
#  applied_date :datetime
#  param_code   :string
#  param_name   :string
#  value_int    :decimal(15, 4)
#  value_text   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class SystemParameter < ApplicationRecord
  include Ransackable

  scope :available, -> {
    where(applied_date: ..Time.current)
  }

  scope :company_announcement_public, -> {
    where(param_code: 'company_announcement_public')
  }

  scope :company_announcement, -> {
    where(param_code: 'company_announcement')
  }

  scope :partner_announcement, -> {
    where(param_code: 'partner_announcement')
  }
end
