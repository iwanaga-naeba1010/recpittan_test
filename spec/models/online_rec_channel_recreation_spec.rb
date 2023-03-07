# frozen_string_literal: true

# == Schema Information
#
# Table name: online_rec_channel_recreations
#
#  id                    :bigint           not null, primary key
#  date                  :date             not null
#  recreation_link       :text             not null
#  recreation_memo       :text
#  recreation_title      :string           not null
#  zoom_link             :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  online_rec_channel_id :bigint           not null
#
# Indexes
#
#  index_online_rec_channel_recreations_on_online_rec_channel_id  (online_rec_channel_id)
#  index_online_rec_channel_recs_on_online_rec_channel_date       (online_rec_channel_id,date) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (online_rec_channel_id => online_rec_channels.id)
#
require 'rails_helper'

RSpec.describe OnlineRecChannelRecreation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
