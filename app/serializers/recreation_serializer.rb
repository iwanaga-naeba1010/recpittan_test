# frozen_string_literal: true

class RecreationSerializer
  def serialize_list(recreations:)
    recreations.map { |recreation| serialize(recreation: recreation) }
  end

  def serialize(recreation:)
    tags = TagSerializer.new.serialize_list(tags: recreation.tags)
    targets = TagSerializer.new.serialize_list(tags: recreation.tags.targets)
    {
      id: recreation.id,
      title: recreation.title,
      second_title: recreation.second_title,
      minutes: recreation.minutes,
      is_online: recreation.is_online,
      capacity: recreation.capacity,
      image_url: recreation.recreation_images.sliders&.first&.image.to_s,
      category: recreation.category,
      category_id: recreation.category.value,
      tags: tags,
      targets: targets
    }
  end
end
