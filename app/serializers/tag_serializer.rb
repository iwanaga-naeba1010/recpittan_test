# frozen_string_literal: true

class TagSerializer
  def serialize_list(tags:)
    tags.map { |tag| serialize(tag: tag) }
  end

  def serialize(tag:)
    {
      id: tag.id,
      name: tag.name
    }
  end
end
