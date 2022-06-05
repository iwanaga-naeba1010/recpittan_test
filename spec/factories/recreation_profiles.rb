# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_profiles
#
#  id            :bigint           not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  profile_id    :bigint           not null
#  recreation_id :bigint           not null
#
# Indexes
#
#  index_recreation_profiles_on_profile_id     (profile_id)
#  index_recreation_profiles_on_recreation_id  (recreation_id)
#
# Foreign Keys
#
#  fk_rails_...  (profile_id => profiles.id)
#  fk_rails_...  (recreation_id => recreations.id)
#
FactoryBot.define do
  factory :recreation_profile do
    recreation
    profile
  end
end
