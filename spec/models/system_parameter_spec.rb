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
require 'rails_helper'

RSpec.describe SystemParameter, type: :model do
  it { is_expected.to have_db_column(:param_code).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:param_name).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:value_int).of_type(:decimal).with_options(precision: 15, scale: 4, null: true) }
  it { is_expected.to have_db_column(:value_text).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:applied_date).of_type(:datetime).with_options(null: true) }
end
