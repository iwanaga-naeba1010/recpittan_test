# frozen_string_literal: true

class ChatSerializer
  def serialize_list(chats:)
    serialized_list = chats.map { |chat| serialize(chat: chat) }
    # NOTE(okubo): 日付ごとにdataまとめている
    serialized_list.group_by { |p| p[:created_at].strftime('%Y年-%m月-%d日') }
  end

  def serialize(chat:)
    {
      id: chat.id,
      user_id: chat.user_id,
      order_id: chat.order_id,
      message: chat.message,
      filename: chat.file.present? ? chat.file.file.filename : '',
      file_url: chat.file.url,
      created_at: chat.created_at,
      updated_at: chat.updated_at
    }
  end
end
