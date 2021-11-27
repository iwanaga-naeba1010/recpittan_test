# frozen_string_literal: true

# == Schema Information
#
# Table name: recreations
#
#  id                         :bigint           not null, primary key
#  base_code                  :string
#  borrow_item                :text
#  bring_your_own_item        :text
#  capacity                   :integer
#  description                :text
#  extra_information          :text
#  flow_of_day                :text
#  flyer_color                :string
#  instructor_amount          :integer
#  instructor_description     :text
#  instructor_image           :text
#  instructor_material_amount :integer
#  instructor_name            :string
#  instructor_position        :string
#  instructor_title           :string
#  is_online                  :boolean          default(FALSE)
#  is_public                  :boolean
#  minutes                    :integer
#  prefectures                :string           default([]), is an Array
#  price                      :integer          default(0), not null
#  regular_material_price     :integer
#  regular_price              :integer
#  second_title               :string
#  title                      :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  user_id                    :bigint           not null
#  youtube_id                 :string
#
# Indexes
#
#  index_recreations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Recreation < ApplicationRecord
  mount_uploader :instructor_image, ImageUploader
  has_many :recreation_tags, dependent: :destroy
  has_many :tags, through: :recreation_tags

  has_many :recreation_images, dependent: :destroy
  accepts_nested_attributes_for :recreation_images, allow_destroy: true

  has_many :orders, dependent: :destroy

  delegate :name, to: :partner, prefix: true
  delegate :title, to: :partner, prefix: true
  delegate :description, to: :partner, prefix: true
  delegate :image, to: :partner, prefix: true
end
