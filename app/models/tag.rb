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
  has_many :recreation_tags, dependent: :destroy, class_name: 'RecreationTag'
  has_many :recreations, through: :recreation_tags, class_name: 'Recreation'
  has_many :recreation_plan_tags, dependent: :destroy, class_name: 'RecreationPlanTag'
  has_many :recreation_plans, through: :recreation_plan_tags, class_name: 'RecreationPlan'

  # TODO(okubo): category利用していないので削除したい
  enumerize :kind, in: { category: 0, tag: 1, target: 2, rental: 3, plan: 4 }, default: 1

  # TODO(okubo): categoriesも削除対象
  scope :categories, -> { where(kind: :category) }
  scope :events, -> { where(kind: :tag) } # TODO: tagsに変更
  scope :targets, -> { where(kind: :target) }
  scope :plans, -> { where(kind: :plan) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value kind name updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[recreation_plan_tags recreation_plans recreation_tags recreations]
  end
end
