# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_images
#
#  id            :bigint           not null, primary key
#  document_kind :string
#  filename      :string
#  image         :text
#  kind          :integer          default("slider")
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#
# Foreign Keys
#
#  recreation_images_recreation_id_fkey  (recreation_id => recreations.id)
#
class RecreationImageSerializer
  def serialize_list(recreation_images:)
    recreation_images.map { |image| serialize(recreation_image: image) }
  end

  def serialize(recreation_image:)
    {
      id: recreation_image.id,
      image_url: recreation_image.image.to_s,
      filename: recreation_image.filename,
      kind: recreation_image.kind,
      title: recreation_image.title,
    }
  end
end
