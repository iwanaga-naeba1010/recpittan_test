# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_recreation_plans
#
#  id                 :bigint           not null, primary key
#  month              :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  recreation_id      :bigint           not null
#  recreation_plan_id :bigint           not null
#
# Indexes
#
#  index_recreation_recreation_plans_on_recreation_id       (recreation_id)
#  index_recreation_recreation_plans_on_recreation_plan_id  (recreation_plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
#  fk_rails_...  (recreation_plan_id => recreation_plans.id)
#
class RecreationRecreationPlanSerializer
  def serialize_list(recreation_recreation_plans:)
    recreation_recreation_plans.map { |recreation_recreation_plan| serialize(recreation_recreation_plan:) }
  end

  def serialize(recreation_recreation_plan:)
    recreations = RecreationSerializer.new.serialize_list(recreations: recreation_plan.recreations)
    {
      month: recreation_recreation_plan.month,
      recreations:
    }
  end
end
