# frozen_string_literal: true

# == Schema Information
#
# Table name: online_rec_channels
#
#  id                  :bigint           not null, primary key
#  calendar_field_memo :text
#  image               :text
#  period              :date             not null
#  status              :integer          not null
#  zoom_field_memo     :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
require 'rails_helper'

RSpec.describe OnlineRecChannel, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
