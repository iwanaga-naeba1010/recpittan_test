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
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Profile < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user, class_name: 'User'
  has_one :recreation_profile, dependent: :destroy, class_name: 'RecreationProfile'
  has_one :recreation, through: :recreation_profile, class_name: 'Recreation'

  # TODO(okubo): 一時的にdescriptionのvalidationを外してバッチの不具合を回避
  # validates :name, :description, presence: true
  validates :name, :description, :image, presence: true

  before_destroy :check_recreation_association

  private def check_recreation_association
    if recreation_profile&.recreation.present?
      errors.add(:base, 'このプロフィールは関連するレクがあるため削除できません。')
      throw :abort
    end
  end
end
