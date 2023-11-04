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
FactoryBot.define do
  factory :user_recreation_plan do
    title { 'MyString' }
    code { 'MyString' }
    user
  end
end
