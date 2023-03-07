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
class OnlineRecChannel < ApplicationRecord
  extend Enumerize
  mount_uploader :image, ImageUploader

  has_many :online_rec_channel_recreations, dependent: :destroy
  accepts_nested_attributes_for :online_rec_channel_recreations, allow_destroy: true

  enumerize :status, in: { public: 0, private: 1 }, default: 0

  validate :unique_period_status_combination

  private

  def unique_period_status_combination
    if OnlineRecChannel.where(period: period.all_month, status: 'public').where.not(id:).exists?
      errors.add(:period, 'その年月のレクは既に存在します')
    end
  end
end
