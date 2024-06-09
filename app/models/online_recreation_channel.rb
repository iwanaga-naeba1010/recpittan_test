# frozen_string_literal: true

# == Schema Information
#
# Table name: online_recreation_channels
#
#  id            :bigint           not null, primary key
#  calendar_memo :text
#  period        :date             not null
#  status        :integer          not null
#  top_image     :text
#  zoom_memo     :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class OnlineRecreationChannel < ApplicationRecord
  extend Enumerize
  mount_uploader :top_image, ImageUploader

  has_many :channel_recreations,
           class_name: 'OnlineRecreationChannelRecreation',
           inverse_of: :online_recreation_channel,
           dependent: :destroy
  accepts_nested_attributes_for :channel_recreations, allow_destroy: true
  has_many :channel_download_images,
           class_name: 'OnlineRecreationChannelDownloadImage',
           inverse_of: :online_recreation_channel,
           dependent: :destroy
  accepts_nested_attributes_for :channel_download_images, allow_destroy: true

  enumerize :status, in: { public: 0, private: 1 }, default: 0

  validates :period, :status, presence: true
  validate :unique_period_status_combination

  delegate :image, :kind, to: :online_recreation_channel_download_images, prefix: true

  private def unique_period_status_combination
    if OnlineRecreationChannel.where(period: period&.all_month, status: :public).where.not(id:).exists?
      errors.add(:period, 'その年月のレクは既に存在します')
    end
  end
end
