# frozen_string_literal: true

# == Schema Information
#
# Table name: user_recreation_plans
#
#  id                 :bigint           not null, primary key
#  code               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  recreation_plan_id :bigint           not null
#  user_id            :bigint           not null
#
# Indexes
#
#  index_user_recreation_plans_on_code                (code) UNIQUE
#  index_user_recreation_plans_on_recreation_plan_id  (recreation_plan_id)
#  index_user_recreation_plans_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_plan_id => recreation_plans.id)
#  fk_rails_...  (user_id => users.id)
#
class UserRecreationPlanSerializer
  def serialize(user_recreation_plan:)
    user_recreation_recreation_plans = UserRecreationRecreationPlanSerializer.new.serialize_list(
      user_recreation_recreation_plans: user_recreation_plan.user_recreation_recreation_plans
    )
    {
      id: user_recreation_plan.id,
      title: user_recreation_plan.recreation_plan_title,
      code: user_recreation_plan.code,
      user_recreation_recreation_plans:,
    }
  end
end
