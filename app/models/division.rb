# frozen_string_literal: true

# == Schema Information
#
# Table name: divisions
#
#  id         :bigint           not null, primary key
#  classname  :string
#  code       :string
#  disporder  :integer
#  i18n_class :string
#  i18n_flag  :boolean
#  key        :string
#  memo       :text
#  valuedate  :datetime
#  valueint   :integer
#  valuetext  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Division < ApplicationRecord
end
