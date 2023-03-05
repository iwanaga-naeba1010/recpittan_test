# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  kind       :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TagSerializer
  def serialize_list(tags:)
    tags.map { |tag| serialize(tag:) }
  end

  def serialize(tag:)
    {
      id: tag.id,
      name: tag.name
    }
  end
end
