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
class OnlineRecreationChannelDownloadImage < ApplicationRecord
  extend Enumerize
  mount_uploader :image, ImageUploader
  belongs_to :online_recreation_channel

  enumerize :kind, in: { calendar_image: 0, calendar_pdf: 1, flyer_image: 2, flyer_pdf: 3 }

  scope :calendar_image, -> { find_by(kind: :calendar_image) }
  scope :calendar_pdf, -> { find_by(kind: :calendar_pdf) }
  scope :flyer_image, -> { find_by(kind: :flyer_image) }
  scope :flyer_pdf, -> { find_by(kind: :flyer_pdf) }

  validates :online_recreation_channel_id, uniqueness: { scope: :kind }
end
