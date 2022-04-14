# frozen_string_literal: true

class ChatSerializer
  def serialize_list(chats:)
    chats.map { |chat| serialize(chat: chat) }
  end

  def serialize(chat:)
    {
      id: chat.id,
      order_id: chat.order_id,
      message: chat.message,
      file_url: chat.file.url
    }
  end
end
