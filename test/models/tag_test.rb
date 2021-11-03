# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  image      :text
#  kind       :integer
#  name       :string
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test 'the truth' do
  #   assert true
  # end
end
