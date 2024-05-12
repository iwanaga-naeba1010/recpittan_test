# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_plan_tags
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  recreation_plan_id :bigint           not null
#  tag_id             :bigint           not null
#
# Indexes
#
#  index_recreation_plan_tags_on_recreation_plan_id  (recreation_plan_id)
#  index_recreation_plan_tags_on_tag_id              (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_plan_id => recreation_plans.id)
#  fk_rails_...  (tag_id => tags.id)
#
class RecreationPlanTag < ApplicationRecord
  belongs_to :recreation_plan, class_name: 'RecreationPlan'
  belongs_to :tag, class_name: 'Tag'
end
