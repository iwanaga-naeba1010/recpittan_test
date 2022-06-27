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
class RecreationImageSerializer
  def serialize_list(recreation_images:)
    recreation_images.map { |image| serialize(recreation_image: image) }
  end

  def serialize(recreation_image:)
    {
      id: recreation_image.id,
      image_url: recreation_image.image.to_s,
      kind: recreation_image.kind,
    }
  end
end
