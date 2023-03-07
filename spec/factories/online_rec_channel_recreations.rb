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
FactoryBot.define do
  factory :online_rec_channel_recreation do
    online_rec_channel
    recreation_link { 'MyText' }
    recreation_memo { 'MyText' }
    recreation_title { 'MyString' }
    zoom_link { 'MyText' }
    date { '2023-03-13' }
  end
end
