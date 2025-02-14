# frozen_string_literal: true

# == Schema Information
#
# Table name: m_numberings
#
#  id                 :bigint           not null, primary key
#  code               :string           not null
#  code_name          :string           not null
#  numbering_datetime :text
#  numbering_name     :string           not null
#  numbering_unit     :string           not null
#  numbering_value    :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  idx_on_numbering_name_numbering_unit_numbering_date_5c271ae9b2  (numbering_name,numbering_unit,numbering_datetime,code) UNIQUE
#
class MNumbering < ApplicationRecord
  enum :numbering_name, {
    partner: 'partner',   # 取引先コード
    facility: 'facility', # 施設コード
    plan: 'plan'          # 公開用プランコード
  }

  enum :numbering_unit, {
    year: 'year', # 年
    year_month: 'year_month', # 年月
    date: 'date', # 年月日
    serial_number: 'serial_number' # 通番
  }
end
