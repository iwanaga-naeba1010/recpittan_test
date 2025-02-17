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
# Indexes
#
#  index_recreation_images_on_recreation_id  (recreation_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
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
    }
  end
end
