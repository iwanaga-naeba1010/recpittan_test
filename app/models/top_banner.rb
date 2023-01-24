# frozen_string_literal: true

# == Schema Information
#
# Table name: top_banners
#
#  id         :bigint           not null, primary key
#  end_date   :date             not null
#  image      :string           not null
#  start_date :date             not null
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TopBanner < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :image, :start_date, :end_date, presence: true
  validate :validate_display_date_no_overlap

  private

  def validate_display_date_no_overlap
    top_banners = TopBanner.where(start_date: start_date..end_date).or(TopBanner.where(end_date: start_date..end_date))
    top_banners = top_banners.where.not(id: id) if id.present?
    if top_banners.exists?
      errors.add(:base, '表示日が他のレコードと重複しています')
    end
  end
end
