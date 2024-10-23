# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id          :bigint           not null, primary key
#  description :text
#  image       :text
#  name        :string
#  position    :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ProfileSerializer
  def serialize_list(profiles:)
    profiles.map { |profile| serialize(profile:) }
  end

  def serialize(profile:)
    {
      id: profile.id,
      name: profile.name,
      title: profile.title,
      position: profile.position,
      description: profile.description,
      image: profile.image&.to_s,
      created_at: profile.created_at,
      updated_at: profile.updated_at
    }
  end
end
