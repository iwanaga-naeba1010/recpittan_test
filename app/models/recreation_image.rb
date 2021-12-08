# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_images
#
#  id            :bigint           not null, primary key
#  image         :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#
# Indexes
#
#  index_recreation_images_on_recreation_id  (recreation_id)
#
# Foreign Keys
#
#  fk_rails_...                          (recreation_id => recreations.id)
#  recreation_images_recreation_id_fkey  (recreation_id => recreations.id)
#
class RecreationImage < ApplicationRecord
  belongs_to :recreation
  mount_uploader :image, ImageUploader

  validates :image, presence: true
end
