# frozen_string_literal: true

# == Schema Information
#
# Table name: channel_plan_subscribers
#
#  id         :bigint           not null, primary key
#  kind       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#
# Indexes
#
#  index_channel_plan_subscribers_on_company_id  (company_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
FactoryBot.define do
  factory :channel_plan_subscriber do
    kind { 0 }
    company
  end
end
