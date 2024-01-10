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
  has_many :recreation_plan_tags, dependent: :destroy
  has_many :recreation_plans, through: :recreation_plan_tags

  # TODO(okubo): category利用していないので削除したい
  enumerize :kind, in: { category: 0, tag: 1, target: 2, rental: 3, plan: 4 }, default: 1

  # TODO(okubo): categoriesも削除対象
  scope :categories, -> { where(kind: :category) }
  scope :events, -> { where(kind: :tag) } # TODO: tagsに変更
  scope :targets, -> { where(kind: :target) }
  scope :plans, -> { where(kind: :plan) }
end
