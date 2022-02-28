# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_files
#
#  id            :bigint           not null, primary key
#  kind          :integer          default(0)
#  source        :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#
# Foreign Keys
#
#  recreation_images_recreation_id_fkey  (recreation_id => recreations.id)
#
class RecreationFile < ApplicationRecord
  extend Enumerize
  belongs_to :recreation
  mount_uploader :source, ImageUploader

  validates :source, presence: true
  enumerize :kind, in: { slider: 0, flyer: 1, material: 2 }, default: 0

  scope :sliders, -> { where(kind: :slider) }
  # scope :flyers, -> { where(kind: :flyer) }
  # scope :materials, -> { where(kind: :material) }
end
