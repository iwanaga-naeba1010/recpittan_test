# frozen_string_literal: true

class Profile < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user

  validates :name, :description, presence: true
end
