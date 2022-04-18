# frozen_string_literal: true

class UserSerializer
  def serialize_list(users:)
    users.map { |user| serialize(user: user) }
  end

  def serialize(user:)
    {
      id: user.id
    }
  end
end
