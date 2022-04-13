# frozen_string_literal: true

class RecreationSerializer
  def serialize_list(recreations:)
    recreations.map { |recreation| serialize(recreation: recreation) }
  end

  def serialize(recreation:)
    {
      id: recreation.id,
      is_online: recreation.is_online
    }
  end
end
