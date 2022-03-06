# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_images
#
#  id            :bigint           not null, primary key
#  image         :text
#  kind          :integer          default("slider")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#
# Foreign Keys
#
#  recreation_images_recreation_id_fkey  (recreation_id => recreations.id)
#
class RecreationImage < ApplicationRecord
  extend Enumerize
  belongs_to :recreation
  mount_uploader :image, RecreationImageUploader

  validates :image, presence: true
  enumerize :kind, in: { slider: 0, flyer: 1, material: 2 }, default: 0

  scope :sliders, -> { where(kind: :slider) }
  scope :flyers, -> { where(kind: :flyer) }
  scope :materials, -> { where(kind: :material) }
end
