# frozen_string_literal: true

# == Schema Information
#
# Table name: online_recreation_channel_recreations
#
#  id                           :bigint           not null, primary key
#  date                         :date
#  datetime                     :datetime
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
class OnlineRecreationChannelRecreation < ApplicationRecord
  belongs_to :online_recreation_channel,
             class_name: 'OnlineRecreationChannel',
             inverse_of: :channel_recreations
  validates :title, :datetime, presence: true
end
