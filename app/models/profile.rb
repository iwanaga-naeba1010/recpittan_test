# frozen_string_literal: true

class Profile < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_many :user_recreations, dependent: :destroy
  has_many :recreations, through: :user_recreations
  has_many :recreation_profiles, dependent: :destroy
  has_many :profiles, through: :recreation_profiles

  validates :name, :description, presence: true
end
