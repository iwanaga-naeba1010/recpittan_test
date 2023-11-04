# frozen_string_literal: true

# == Schema Information
#
# Table name: user_recreation_plans
#
#  id         :bigint           not null, primary key
#  code       :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_recreation_plans_on_code     (code) UNIQUE
#  index_user_recreation_plans_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserRecreationPlan < ApplicationRecord
  belongs_to :user
  has_many :user_recreation_recreation_plans, dependent: :destroy
  has_many :recreations, through: :user_recreation_recreation_plans
end
