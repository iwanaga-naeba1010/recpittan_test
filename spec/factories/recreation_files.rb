# frozen_string_literal: true

# == Schema Information
#
# Table name: recreation_files
#
#  id            :bigint           not null, primary key
#  kind          :integer          default(0)
#  source        :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  recreation_id :bigint           not null
#
# Foreign Keys
#
#  recreation_images_recreation_id_fkey  (recreation_id => recreations.id)
#
FactoryBot.define do
  factory :recreation_file do
    recreation
    kind { 0 }
    source do
      ActionDispatch::Http::UploadedFile.new(
        filename: 'test.png',
        type: 'image/png',
        tempfile: File.open(Rails.root.join('spec/files/test.png'))
      )
    end
  end
end
