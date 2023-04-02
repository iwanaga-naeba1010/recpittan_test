# frozen_string_literal: true

# == Schema Information
#
# Table name: online_recreation_channels
#
#  id             :bigint           not null, primary key
#  calendar_image :text
#  calendar_memo  :text
#  calendar_pdf   :text
#  flyer_image    :text
#  flyer_pdf      :text
#  period         :date             not null
#  status         :integer          not null
#  top_image      :text
#  zoom_memo      :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe OnlineRecreationChannel, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
