# frozen_string_literal: true

# == Schema Information
#
# Table name: online_recreation_channel_download_images
#
#  id                           :bigint           not null, primary key
#  image                        :text             not null
#  kind                         :integer          not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  online_recreation_channel_id :bigint           not null
#
# Indexes
#
#  index_channel_dw_images_on_channel_id_and_kind           (online_recreation_channel_id,kind) UNIQUE
#  index_online_recreation_channel_dw_images_on_channel_id  (online_recreation_channel_id)
#
# Foreign Keys
#
#  fk_rails_...  (online_recreation_channel_id => online_recreation_channels.id)
#
require 'rails_helper'

RSpec.describe OnlineRecreationChannelDownloadImage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
