# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register OnlineRecreationChannel do
  permit_params(
    :top_image, :period, :status, :calendar_memo, :zoom_memo,
    online_recreation_channel_recreations_attributes: %i[
      id date title link memo zoom_link online_recreation_channel_id _destroy
    ],
    online_recreation_channel_download_images_attributes: %i[
      id image kind online_recreation_channel_id _destroy
    ]
  )

  index do
    id_column
    column(:image) do |top_banner|
      image_tag top_banner&.top_image&.to_s, width: 50, height: 50
    end
    column :period
    column(:status, &:status_text)
    column :calendar_memo do |resource|
      truncate(resource.calendar_memo, length: 100)
    end
    column :zoom_memo do |resource|
      truncate(resource.zoom_memo, length: 100)
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row(:top_image) do |image|
        image_tag image&.top_image&.to_s, width: 50, height: 50
      end
      row :period
      row(:status, &:status_text)
      row :calendar_memo
      row :zoom_memo
      row :created_at
      row :updated_at
    end

    panel t('activerecord.models.online_recreation_channel_download_image').to_s, style: 'margin-top: 30px;' do
      table_for online_recreation_channel.online_recreation_channel_download_images do
        column :id
        column(:kind, &:kind_text)
        column :image do |image|
          if image.image.file.content_type == 'application/pdf'
            link_to image.image.url, image.image.url
          else
            image_tag image.image.url, width: 50, height: 50
          end
        end
      end
    end

    panel t('activerecord.models.online_recreation_channel_recreation').to_s, style: 'margin-top: 30px;' do
      table_for online_recreation_channel.online_recreation_channel_recreations.order(date: :asc) do
        column :id
        column :date
        column :title
        column :link
        column :memo
        column :zoom_link do |resource|
          truncate(resource.zoom_link, length: 100)
        end
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :top_image
      f.input :period
      f.input :status, as: :select, collection: OnlineRecreationChannel.status.values.map { |val| [val.text, val] }
      f.input :calendar_memo
      f.input :zoom_memo
    end
    f.inputs t('activerecord.models.online_recreation_channel_download_image') do
      f.has_many :online_recreation_channel_download_images, heading: false, allow_destroy: true, new_record: true do |ff|
        ff.input :image
        ff.input :kind, as: :select, collection: OnlineRecreationChannelDownloadImage.kind.values.map { |val| [val.text, val] }
      end
    end
    # NOTE: レクの表示順を任意のものに設定できるようにするために、RecreationTopRecommendRecreationのフォームを設置
    f.inputs t('activerecord.models.online_recreation_channel_recreation') do
      f.has_many :online_recreation_channel_recreations, heading: false, allow_destroy: true, new_record: true do |ff|
        ff.input :date, as: :datepicker
        ff.input :title
        ff.input :link, as: :string
        ff.input :memo, as: :string
        ff.input :zoom_link
      end
    end

    f.actions
  end
end
# rubocop:enable Metrics/BlockLength
