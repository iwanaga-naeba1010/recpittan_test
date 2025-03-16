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
FactoryBot.define do
  factory :recreation_image do
    recreation
    kind { 0 }
    filename { 'filename' }
    image do
      ActionDispatch::Http::UploadedFile.new(
        filename: 'test.png',
        type: 'image/png',
        tempfile: Rails.root.join('spec/files/test.png').open
      )
    end
  end
end
