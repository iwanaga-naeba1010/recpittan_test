# frozen_string_literal: true

# == Schema Information
#
# Table name: online_recreation_channel_recreations
#
#  id                           :bigint           not null, primary key
#  date                         :date             not null
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
FactoryBot.define do
  factory :online_recreation_channel_recreation do
    online_recreation_channel
    recreation_link { 'MyText' }
    recreation_memo { 'MyText' }
    recreation_title { 'MyString' }
    zoom_link { 'MyText' }
    date { '2023-03-13' }
  end
end
