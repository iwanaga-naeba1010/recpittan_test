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
class EvaluationSerializer
  def serialize_list(evaluations:)
    evaluations.map { |evaluation| serialize(evaluation:) }
  end

  def serialize(evaluation:)
    report = ReportSerializer.new.serialize(report: evaluation.report)
    {
      id: evaluation.id,
      communication: evaluation.communication,
      is_public: evaluation.is_public,
      message: evaluation.message,
      other_message: evaluation.other_message,
      ingenuity: { id: evaluation.ingenuity.value, key: evaluation.ingenuity, text: evaluation.ingenuity_text },
      price: { id: evaluation.price.value, key: evaluation.price, text: evaluation.price_text },
      smoothness: { id: evaluation.smoothness.value, key: evaluation.smoothness, text: evaluation.smoothness_text },
      want_to_order_agein: { id: evaluation.want_to_order_agein.value,
                             key: evaluation.want_to_order_agein,
                             text: evaluation.want_to_order_agein_text },
      report:
    }
  end
end
