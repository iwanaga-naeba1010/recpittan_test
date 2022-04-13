# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Recreation do
  permit_params(
    %i[
      user_id title second_title minutes description category
      flow_of_day borrow_item bring_your_own_item extra_information youtube_id
      base_code capacity flyer_color regular_price instructor_amount instructor_material_amount
      regular_material_price instructor_name instructor_title instructor_description instructor_image
      is_online is_public prefectures is_public_price additional_facility_fee
    ],
    tag_ids: [],
    recreation_images_attributes: %i[id recreation_id image kind _destroy]
  )
  actions :all

  filter :title
  filter :second_title
  filter :minutes
  filter :regular_price
  filter :is_public

  index do
    id_column
    column :user
    column :title
    column :second_title
    column(:category, &:category_text)
    column :minutes
    column :regular_price
    column :is_public_price

    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :title
      row :second_title
      row(:category, &:category_text)
      row :minutes
      row :description
      row :flow_of_day
      row :borrow_item
      row :bring_your_own_item
      row :extra_information
      row :youtube_id
      # row :price
      row :base_code
      row :capacity
      row :flyer_color
      row :regular_price
      row :instructor_amount
      row :instructor_material_amount
      row :regular_material_price
      row :instructor_name
      row :instructor_title
      row :instructor_description
      row :additional_facility_fee

      row t('activerecord.attributes.recreation.instructor_image') do |rec|
        image_tag rec&.instructor_image&.to_s, width: 50, height: 50
      end

      row :is_online
      row :is_public
      row :prefectures
      row :is_public_price

      row :created_at
      row :updated_at
    end

    panel 'イベント種別', style: 'margin-top: 30px;' do
      table_for recreation.tags.events do
        column :id
        column :name
      end
    end

    panel 'カテゴリー', style: 'margin-top: 30px;' do
      table_for recreation.tags.categories do
        column :id
        column :name
      end
    end

    panel '想定ターゲット', style: 'margin-top: 30px;' do
      table_for recreation.tags.targets do
        column :id
        column :name
      end
    end

    panel t('activerecord.models.recreation_image'), style: 'margin-top: 30px;' do
      table_for recreation.recreation_images do
        column t('activerecord.attributes.recreation_image.image') do |rec|
          image_tag rec&.image&.to_s, width: 50, height: 50
        end
        column(:kind, &:kind_text)
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      # pertnerのみ表示
      f.input :user_id,
              label: 'パートナー',
              as: :select,
              collection: User.where(role: :partner).map { |partner| [partner.username, partner.id] },
              input_html: { class: 'select2' }
      f.input :title
      f.input :second_title
      f.input :minutes
      f.input :description
      f.input :flow_of_day
      f.input :borrow_item
      f.input :bring_your_own_item
      f.input :extra_information
      f.input :youtube_id
      # f.input :price

      f.input :base_code
      f.input :capacity
      f.input :flyer_color, as: :string
      f.input :regular_price
      f.input :instructor_amount
      f.input :instructor_material_amount
      f.input :regular_material_price
      f.input :instructor_name
      f.input :instructor_title
      f.input :instructor_description
      f.input :instructor_image, hint: image_tag(f.object.instructor_image.to_s, width: 100)
      f.input :is_online
      f.input :is_public
      f.input :is_public_price
      f.input :prefectures
      f.input :additional_facility_fee, hint: 'エブリ・プラス取り分の1000円 + パートナー支払い分の合計を入力してください'
    end

    f.input :category, as: :select, collection: Recreation.category.values.map { |val| [val.text, val] }
    f.input :tags, label: 'タグ', as: :check_boxes, collection: Tag.events.all
    f.input :tags, label: '想定ターゲット', as: :check_boxes, collection: Tag.targets.all

    # TODO(okubo): kindごとに登録できるようにする
    f.inputs t('enumerize.recreation_image.kind.slider') do
      f.has_many :recreation_images, heading: false, allow_destroy: true, new_record: true do |ff|
        ff.input :image, as: :file, hint: image_tag(ff.object.image.to_s, width: 100)
        ff.input :kind, as: :select, collection: RecreationImage.kind.values.map { |i| [i.text, i] }
      end
    end

    f.actions
  end
end
# rubocop:enable Metrics/BlockLength
