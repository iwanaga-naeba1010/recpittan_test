# frozen_string_literal: true

# == Schema Information
#
# Table name: recreations
#
#  id                      :bigint           not null, primary key
#  additional_facility_fee :integer          default(2000)
#  amount                  :integer
#  base_code               :string
#  borrow_item             :text
#  bring_your_own_item     :text
#  capacity                :integer
#  category                :integer          default("event"), not null
#  description             :text
#  extra_information       :text
#  flow_of_day             :text
#  flyer_color             :string
#  instructor_description  :text
#  instructor_image        :text
#  instructor_name         :string
#  instructor_position     :string
#  instructor_title        :string
#  is_online               :boolean          default(FALSE)
#  is_public               :boolean
#  is_public_price         :boolean          default(TRUE)
#  material_amount         :integer
#  material_price          :integer
#  minutes                 :integer
#  prefectures             :string           default([]), is an Array
#  price                   :integer
#  second_title            :string
#  title                   :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :bigint           not null
#  youtube_id              :string
#
# Foreign Keys
#
#  recreations_user_id_fkey  (user_id => users.id)
#
class ProfileSerializer
  def serialize_list(profiles:)
    profiles.map { |profile| serialize(profile: profile) }
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
