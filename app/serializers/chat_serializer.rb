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
class ChatSerializer
  def serialize_list(chats:)
    serialized_list = chats.map { |chat| serialize(chat:) }
    # NOTE(okubo): 日付ごとにdataまとめている
    serialized_list.group_by { |p| p[:created_at].strftime('%Y年-%m月-%d日') }
  end

  def serialize(chat:)
    {
      id: chat.id,
      user_id: chat.user_id,
      order_id: chat.order_id,
      message: chat.message,
      filename: chat.file? ? chat.file.file.filename : '',
      file_url: chat.file.url,
      created_at: chat.created_at,
      updated_at: chat.updated_at
    }
  end
end
