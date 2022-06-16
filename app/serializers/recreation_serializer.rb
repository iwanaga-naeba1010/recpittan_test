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
#  is_public_price         :boolean          default(TRUE)
#  kind                    :integer          default("visit"), not null
#  material_amount         :integer
#  material_price          :integer
#  minutes                 :integer
#  price                   :integer
#  second_title            :string
#  status                  :integer          default("unapplied"), not null
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

  def serialize(recreation:) # rubocop:disable Metrics/AbcSize
    tags = TagSerializer.new.serialize_list(tags: recreation.tags)
    targets = TagSerializer.new.serialize_list(tags: recreation.tags.targets)
    profile = ProfileSerializer.new.serialize(profile: recreation.profile)
    {
      id: recreation.id,
      title: recreation.title,
      second_title: recreation.second_title,
      minutes: recreation.minutes,
      description: recreation.description,
      price: recreation.price,
      kind: { id: recreation.kind.value, key: recreation.kind, text: recreation.kind_text },
      status: { id: recreation.status.value, key: recreation.status, text: recreation.status_text },
      category: { id: recreation.category.value, key: recreation.category, text: recreation.category_text },
      flow_of_day: recreation.flow_of_day,
      capacity: recreation.capacity,
      material_price: recreation.material_price,
      extra_information: recreation.extra_information,
      youtube_id: recreation.youtube_id,
      borrow_item: recreation.borrow_item,
      bring_your_own_item: recreation.bring_your_own_item,
      additional_facility_fee: recreation.additional_facility_fee,
      image_url: recreation.recreation_images.sliders&.first&.image.to_s,
      profile: profile,
      user_id: recreation.user_id,
      tags: tags,
      targets: targets
    }
  end
end
