# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_plans
#
#  id             :bigint           not null, primary key
#  adjustment_fee :integer
#  code           :string           not null
#  release_status :integer          default("draft"), not null
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  company_id     :bigint
#
# Indexes
#
#  index_recreation_plans_on_code        (code) UNIQUE
#  index_recreation_plans_on_company_id  (company_id)
#
class RecreationPlanSerializer
  def serialize(recreation_plan:)
    recreation_recreation_plans = RecreationRecreationPlanSerializer.new.serialize_list(
      recreation_recreation_plans: recreation_plan.recreation_recreation_plans
    )
    tags = TagSerializer.new.serialize_list(tags: recreation_plan.tags)
    {
      id: recreation_plan.id,
      title: recreation_plan.title,
      code: recreation_plan.code,
      adjustment_fee: recreation_plan.adjustment_fee,
      recreation_recreation_plans:,
      tags:
    }
  end
end
