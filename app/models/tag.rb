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

  enumerize :kind, in: { category: 0, tag: 1, target: 2 }, default: 0

  scope :categories, -> { where(kind: :category) }
  scope :events, -> { where(kind: :tag) } # TODO: tagsに変更
  scope :targets, -> { where(kind: :target) }

  # NOTE: 一覧表示の際にtargets以外を表示
  scope :categories_and_tags, -> { where(kind: :category).or(where(kind: :tag)) }
end
