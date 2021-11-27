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
#  instructor_material_amount :integer
#  instructor_position        :string
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
#  partner_id                 :bigint           not null
#  youtube_id                 :string
#
# Indexes
#
#  index_recreations_on_partner_id  (partner_id)
#
# Foreign Keys
#
#  fk_rails_...  (partner_id => partners.id)
#
class Recreation < ApplicationRecord
  belongs_to :partner

  has_many :recreation_tags, dependent: :destroy
  has_many :tags, through: :recreation_tags

  has_many :recreation_images, dependent: :destroy
  accepts_nested_attributes_for :recreation_images, allow_destroy: true

  has_many :orders, dependent: :destroy
end
