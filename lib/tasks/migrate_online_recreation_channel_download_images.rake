# frozen_string_literal: true

namespace :migrate_online_recreation_channel_download_images do
  desc 'Migrate images from OnlineRecreationChannel to OnlineRecreationChannelDownloadImage'
  task execute: :environment do
    def migrate_images_to_download_images
      OnlineRecreationChannel.find_each do |channel|
        # calendar_image
        if channel.calendar_image.present?
          OnlineRecreationChannelDownloadImage.create!(
            online_recreation_channel_id: channel.id,
            image: channel.calendar_image,
            kind: :calendar_image
          )
        end

        # calendar_pdf
        if channel.calendar_pdf.present?
          OnlineRecreationChannelDownloadImage.create!(
            online_recreation_channel_id: channel.id,
            image: channel.calendar_pdf,
            kind: :calendar_pdf
          )
        end

        # flyer_image
        if channel.flyer_image.present?
          OnlineRecreationChannelDownloadImage.create!(
            online_recreation_channel_id: channel.id,
            image: channel.flyer_image,
            kind: :flyer_image
          )
        end

        # flyer_pdf
        if channel.flyer_pdf.present?
          OnlineRecreationChannelDownloadImage.create!(
            online_recreation_channel_id: channel.id,
            image: channel.flyer_pdf,
            kind: :flyer_pdf
          )
        end
      end
    end

    migrate_images_to_download_images
    puts 'Images migration from OnlineRecreationChannel to OnlineRecreationChannelDownloadImage completed!'
  end
end
