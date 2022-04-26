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
      category: recreation.category_text,
      category_id: recreation.category.value,
      instructor_description: recreation.instructor_description,
      instructor_image: recreation.instructor_image.to_s,
      instructor_name: recreation.instructor_name,
      instructor_position: recreation.instructor_position,
      instructor_title: recreation.instructor_title,
      tags: tags,
      targets: targets
    }
  end
end
