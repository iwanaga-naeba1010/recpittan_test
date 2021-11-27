# frozen_string_literal: true

# == Schema Information
#
# Table name: recreations
#
#  id                  :bigint           not null, primary key
#  borrow_item         :text
#  bring_your_own_item :text
#  description         :text
#  extra_information   :text
#  flow_of_day         :text
#  minutes             :integer
#  price               :integer          default(0), not null
#  second_title        :string
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  partner_id          :bigint
#  youtube_id          :string
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

  delegate :name, to: :partner, prefix: true
  delegate :title, to: :partner, prefix: true
  delegate :description, to: :partner, prefix: true
  delegate :image, to: :partner, prefix: true
end
