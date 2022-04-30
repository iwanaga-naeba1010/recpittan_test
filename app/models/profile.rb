# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :text
#  name        :string
#  position    :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Foreign Keys
#
#  profiles_user_id_fkey  (user_id => users.id)
#
class Profile < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  has_one :recreation_profile, dependent: :destroy
  has_one :recreation, through: :recreation_profile

  # TODO(okubo): 一時的にdescriptionのvalidationを外してバッチの不具合を回避
  # validates :name, :description, presence: true
  validates :name, presence: true
end
