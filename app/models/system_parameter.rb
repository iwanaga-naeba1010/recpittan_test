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
end
