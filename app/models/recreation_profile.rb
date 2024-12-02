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
# Foreign Keys
#
#  recreation_profiles_profile_id_fkey     (profile_id => profiles.id)
#  recreation_profiles_recreation_id_fkey  (recreation_id => recreations.id)
#
class RecreationProfile < ApplicationRecord
  belongs_to :recreation, class_name: 'Recreation'
  belongs_to :profile, class_name: 'Profile'

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value profile_id recreation_id updated_at]
  end
end
