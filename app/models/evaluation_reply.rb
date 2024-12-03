# frozen_string_literal: true

# == Schema Information
#
# Table name: evaluation_replies
#
#  id            :bigint           not null, primary key
#  message       :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  evaluation_id :bigint           not null
#
# Indexes
#
#  index_evaluation_replies_on_evaluation_id  (evaluation_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (evaluation_id => evaluations.id)
#
class EvaluationReply < ApplicationRecord
  include Ransackable

  belongs_to :evaluation, class_name: 'Evaluation'

  validates :message, presence: true
end
