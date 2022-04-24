# frozen_string_literal: true

class Profile < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user

  has_one :user_recreation, dependent: :destroy
  has_one :user, through: :user_recreation

  validates :name, :description, presence: true
end
