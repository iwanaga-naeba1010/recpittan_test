# frozen_string_literal: true

# == Schema Information
#
# Table name: user_recreation_recreation_plans
#
#  id                      :bigint           not null, primary key
#  month                   :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  recreation_id           :bigint           not null
#  user_recreation_plan_id :bigint           not null
#
# Indexes
#
#  index_user_rec_rec_plans_on_rec_id            (recreation_id)
#  index_user_rec_rec_plans_on_user_rec_plan_id  (user_recreation_plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
#  fk_rails_...  (user_recreation_plan_id => user_recreation_plans.id)
#
class UserRecreationRecreationPlanSerializer < ActiveModel::Serializer
  def serialize_list(user_recreation_recreation_plans:)
    user_recreation_recreation_plans.map { |user_recreation_recreation_plan| serialize(user_recreation_recreation_plan:) }
  end

  def serialize(user_recreation_recreation_plan:)
    recreation = RecreationSerializer.new.serialize(recreation: user_recreation_recreation_plan.recreation)
    {
      month: user_recreation_recreation_plan.month,
      recreation:
    }
  end
end
