# frozen_string_literal: true

# == Schema Information
#
# Table name: channel_plan_subscribers
#
#  id         :bigint           not null, primary key
#  kind       :integer
#  status     :integer          default("active")
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
class ChannelPlanSubscriber < ApplicationRecord
  extend Enumerize

  belongs_to :company, class_name: 'Company'

  has_many :channel_plan_subscriber_memos, dependent: :destroy, class_name: 'ChannelPlanSubscriberMemo'

  validates :company_id, uniqueness: true

  enumerize :kind, in: {
    online_channel: 0,
  }, default: 0

  enumerize :status, in: {
    active: 0, inactive: 1
  }, default: 0
end
