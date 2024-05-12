# frozen_string_literal: true

# == Schema Information
#
# Table name: evaluations
#
#  id                  :bigint           not null, primary key
#  communication       :integer
#  ingenuity           :integer
#  is_public           :boolean          default("public")
#  message             :text
#  other_message       :text
#  price               :integer
#  smoothness          :integer
#  want_to_order_agein :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  report_id           :bigint           not null
#
# Foreign Keys
#
#  evaluations_report_id_fkey  (report_id => reports.id)
#
class Evaluation < ApplicationRecord
  extend Enumerize
  belongs_to :report, class_name: 'Report'
  has_one :evaluation_reply, dependent: :destroy, class_name: 'EvaluationReply'

  scope :with_recreation, ->(recreation_id) { joins(report: :order).where(order: { recreation_id: }) }
  scope :public_and_not_null_message, -> { where(is_public: :public).where.not(message: '').where.not(message: 'システムの自動投稿') }
  scope :latest, ->(count) { order(id: :desc).limit(count) }

  enumerize :ingenuity, in: { satisfied: 0, somewhat_satisfied: 1, neither: 2, somewhat_dissatisfied: 3, dissatisfied: 4 }, default: 0
  enumerize :communication, in: { satisfied: 0, somewhat_satisfied: 1, neither: 2, somewhat_dissatisfied: 3, dissatisfied: 4 }, default: 0
  enumerize :smoothness, in: { satisfied: 0, somewhat_satisfied: 1, neither: 2, somewhat_dissatisfied: 3, dissatisfied: 4 }, default: 0
  enumerize :price, in: { satisfied: 0, somewhat_satisfied: 1, neither: 2, somewhat_dissatisfied: 3, dissatisfied: 4 }, default: 0
  enumerize :want_to_order_agein,
            in: { satisfied: 0, somewhat_satisfied: 1, neither: 2, somewhat_dissatisfied: 3, dissatisfied: 4 }, default: 0
  enumerize :is_public, in: { public: 'true', private: 'false' }, default: :public

  delegate :message, :created_at, to: :evaluation_reply, prefix: true
end
