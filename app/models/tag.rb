# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  kind       :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  extend Enumerize
  has_many :recreation_tags, dependent: :destroy
  has_many :recreations, through: :recreation_tags

  has_many :order_tags, dependent: :destroy
  has_many :orders, through: :order_tags

  enumerize :kind, in: { category: 0, event: 1, target: 2 }, default: 0

  scope :categories, -> { where(kind: :category) }
  scope :events, -> { where(kind: :event) }
  scope :targets, -> { where(kind: :target) }
end
