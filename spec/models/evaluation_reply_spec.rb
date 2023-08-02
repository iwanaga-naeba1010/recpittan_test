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
require 'rails_helper'

RSpec.describe EvaluationReply, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
