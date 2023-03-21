# frozen_string_literal: true

# == Schema Information
#
# Table name: online_recreation_channels
#
#  id            :bigint           not null, primary key
#  calendar_memo :text
#  calendar_pdf  :text
#  calendar_ppt  :text
#  flyer_pdf     :text
#  flyer_ppt     :text
#  image         :text
#  period        :date             not null
#  status        :integer          not null
#  zoom_memo     :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class OnlineRecreationChannel < ApplicationRecord
  extend Enumerize
  mount_uploader :image, ImageUploader

  has_many :online_recreation_channel_recreations, dependent: :destroy
  accepts_nested_attributes_for :online_recreation_channel_recreations, allow_destroy: true

  enumerize :status, in: { public: 0, private: 1 }, default: 0

  validate :unique_period_status_combination

  scope :public_channels, -> { where(status: :public) }
  scope :current_month, -> { where("to_char(period, 'YYYY-MM') = ?", Time.zone.today.strftime('%Y-%m')) }

  private def unique_period_status_combination
    if OnlineRecreationChannel.where(period: period.all_month, status: :public).where.not(id:).exists?
      errors.add(:period, 'その年月のレクは既に存在します')
    end
  end
end
