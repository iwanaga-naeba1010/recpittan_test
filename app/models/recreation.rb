# == Schema Information
#
# Table name: recreations
#
#  id                  :bigint           not null, primary key
#  borrow_item         :text
#  bring_your_own_item :text
#  description         :text
#  extra_information   :text
#  flow_of_day         :text
#  minutes             :integer
#  second_title        :string
#  title               :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_recreations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Recreation < ApplicationRecord
  belongs_to :user

  has_many :recreation_tags, dependent: :destroy
  has_many :tags, through: :recreation_tags
  accepts_nested_attributes_for :recreation_tags, allow_destroy: true

  has_many :recreation_targets, dependent: :destroy
  has_many :targets, through: :recreation_targets
  accepts_nested_attributes_for :recreation_targets, allow_destroy: true
end
