# frozen_string_literal: true

# == Schema Information
#
# Table name: online_recreation_channel_download_images
#
#  id                           :bigint           not null, primary key
#  image                        :text             not null
#  kind                         :integer          not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  online_recreation_channel_id :bigint           not null
#
# Indexes
#
#  index_channel_dw_images_on_channel_id_and_kind           (online_recreation_channel_id,kind) UNIQUE
#  index_online_recreation_channel_dw_images_on_channel_id  (online_recreation_channel_id)
#
# Foreign Keys
#
#  fk_rails_...  (online_recreation_channel_id => online_recreation_channels.id)
#
FactoryBot.define do
  factory :online_recreation_channel_download_image do
    online_recreation_channel

    trait :calendar_image do
      kind { 0 }
      image do
        ActionDispatch::Http::UploadedFile.new(
          filename: 'test.png',
          type: 'image/png',
          tempfile: Rails.root.join('spec/files/test.png').open
        )
      end
    end

    trait :calendar_pdf do
      kind { 1 }
      image do
        ActionDispatch::Http::UploadedFile.new(
          filename: 'test.pdf',
          type: 'image/pdf',
          tempfile: Rails.root.join('spec/files/test.pdf').open
        )
      end
    end

    trait :flyer_image do
      kind { 2 }
      image do
        ActionDispatch::Http::UploadedFile.new(
          filename: 'test.png',
          type: 'image/png',
          tempfile: Rails.root.join('spec/files/test.png').open
        )
      end
    end

    trait :flyer_pdf do
      kind { 3 }
      image do
        ActionDispatch::Http::UploadedFile.new(
          filename: 'test.pdf',
          type: 'image/pdf',
          tempfile: Rails.root.join('spec/files/test.pdf').open
        )
      end
    end
  end
end
