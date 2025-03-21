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
#  i18n_flag  :boolean          default(FALSE)
#  key        :string
#  memo       :text
#  valuedate  :datetime
#  valueint   :integer
#  valuetext  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Division, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
