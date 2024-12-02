# frozen_string_literal: true

# == Schema Information
#
# Table name: chats
#
#  id         :bigint           not null, primary key
#  file       :text
#  is_read    :boolean
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#  user_id    :bigint           not null
#
# Foreign Keys
#
#  chats_order_id_fkey  (order_id => orders.id)
#  chats_user_id_fkey   (user_id => users.id)
#
class Chat < ApplicationRecord
  belongs_to :order, class_name: 'Order'
  belongs_to :user, class_name: 'User'

  delegate :role, to: :user, prefix: true

  validates :message, presence: true
  validate :restrict_file_size

  mount_uploader :file, ChatFileUploader

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at file id id_value is_read message order_id updated_at user_id]
  end

  def restrict_file_size
    if file.size >= 20.megabytes
      errors.add(:file, '20MB以上のファイルは送信できません')
    end
  end
end
