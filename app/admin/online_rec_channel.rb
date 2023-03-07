# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register OnlineRecChannel do
  permit_params(
    :image, :period, :status, :calendar_field_memo, :zoom_field_memo,
    online_rec_channel_recreations_attributes: %i[
      id date recreation_title recreation_link recreation_memo zoom_link online_rec_channel_id _destroy
    ]
  )

  index do
    id_column
    column(:image) do |top_banner|
      image_tag top_banner&.image&.to_s, width: 50, height: 50
    end
    column :period
    column(:status, &:status_text)
    column :calendar_field_memo do |resource|
      truncate(resource.calendar_field_memo, length: 100)
    end
    column :zoom_field_memo do |resource|
      truncate(resource.zoom_field_memo, length: 100)
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row(:image) do |top_banner|
        image_tag top_banner&.image&.to_s, width: 50, height: 50
      end
      row :period
      row(:status, &:status_text)
      row :calendar_field_memo
      row :zoom_field_memo
      row :created_at
      row :updated_at
    end

    panel '開催レク', style: 'margin-top: 30px;' do
      table_for online_rec_channel.online_rec_channel_recreations do
        column :id
        column :date
        column :recreation_title
        column :recreation_link
        column :recreation_memo
        column :zoom_link do |resource|
          truncate(resource.zoom_link, length: 100)
        end
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :image
      f.input :period
      f.input :status, as: :select, collection: OnlineRecChannel.status.values.map { |val| [val.text, val] }
      f.input :calendar_field_memo, as: :string
      f.input :zoom_field_memo, as: :string
    end
    # NOTE: レクの表示順を任意のものに設定できるようにするために、RecreationTopRecommendRecreationのフォームを設置
    f.inputs t('activerecord.models.online_rec_channel_recreation') do
      f.has_many :online_rec_channel_recreations, heading: false, allow_destroy: true, new_record: true do |ff|
        ff.input :date, as: :datepicker
        ff.input :recreation_title
        ff.input :recreation_link, as: :string
        ff.input :recreation_memo, as: :string
        ff.input :zoom_link, as: :string
      end
    end

    f.actions
  end
end
# rubocop:enable Metrics/BlockLength
