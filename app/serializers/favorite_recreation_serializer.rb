# frozen_string_literal: true

# == Schema Information
#
# Table name: favorite_recreations
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_favorite_recreations_on_recreation_id              (recreation_id)
#  index_favorite_recreations_on_user_id                    (user_id)
#  index_favorite_recreations_on_user_id_and_recreation_id  (user_id,recreation_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
#  fk_rails_...  (user_id => users.id)
#
class FavoriteRecreationSerializer
  def serialize_list(favorite_recreations:)
    favorite_recreations.map { |favorite_recreation| serialize(favorite_recreation:) }
  end

  def serialize(favorite_recreation:)
    {
      id: favorite_recreation.id,
      user: UserSerializer.new.serialize(user: favorite_recreation.user),
      recreation: RecreationSerializer.new.serialize(recreation: favorite_recreation.recreation),
      created_at: favorite_recreation.created_at,
      updated_at: favorite_recreation.updated_at,
      is_favorite: true
    }
  end
end
