# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_plans
#
#  id             :bigint           not null, primary key
#  code           :string           not null
#  release_status :integer          default("draft"), not null
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_recreation_plans_on_code  (code) UNIQUE
#
class RecreationPlanSerializer
  def serialize(recreation_plan:)
    recreation_recreation_plans = RecreationRecreationPlanSerializer.new.serialize_list(
      recreation_recreation_plans: recreation_plan.recreation_recreation_plans
    )
    tags = TagSerializer.new.serialize_list(tags: recreation_plan.tags)
    {
      id: recreation_plan.id,
      release_status: { id: recreation_plan.release_status.value,
                        key: recreation_plan.release_status,
                        text: recreation_plan.release_status_text },
      title: recreation_plan.title,
      code: recreation_plan.code,
      recreation_recreation_plans:,
      tags:
    }
  end
end
