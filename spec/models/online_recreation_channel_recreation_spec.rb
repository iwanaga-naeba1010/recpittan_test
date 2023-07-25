# frozen_string_literal: true

# == Schema Information
#
# Table name: online_recreation_channel_recreations
#
#  id                           :bigint           not null, primary key
#  date                         :date
#  datetime                     :datetime         not null
#  link                         :text             not null
#  memo                         :text
#  title                        :string           not null
#  zoom_link                    :text
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  online_recreation_channel_id :bigint           not null
#
# Indexes
#
#  index_channel_recreations_on_channel_date  (online_recreation_channel_id,date) UNIQUE
#  index_channel_recreations_on_channel_id    (online_recreation_channel_id)
#
# Foreign Keys
#
#  fk_rails_...  (online_recreation_channel_id => online_recreation_channels.id)
#
require 'rails_helper'

RSpec.describe OnlineRecreationChannelRecreation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
