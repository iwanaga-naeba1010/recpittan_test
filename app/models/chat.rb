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
# Indexes
#
#  index_chats_on_order_id  (order_id)
#  index_chats_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (user_id => users.id)
#
class Chat < ApplicationRecord
  belongs_to :order, class_name: 'Order'
  belongs_to :user, class_name: 'User'

  delegate :role, to: :user, prefix: true

  validates :message, presence: true
  validate :restrict_file_size

  mount_uploader :file, ChatFileUploader

  def restrict_file_size
    if file.size >= 20.megabytes
      errors.add(:file, '20MB以上のファイルは送信できません')
    end
  end
end
