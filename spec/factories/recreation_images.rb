# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_images
#
#  id            :bigint           not null, primary key
#  image         :text
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
FactoryBot.define do
  factory :recreation_image do
    recreation
    image do
      ActionDispatch::Http::UploadedFile.new(
        filename: 'test.png',
        type: 'image/png',
        tempfile: File.open(Rails.root.join('spec/files/test.png'))
      )
    end
  end
end
