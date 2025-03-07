# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Recreation do
  permit_params(
    %i[
      user_id title second_title minutes description category
      flow_of_day borrow_item bring_your_own_item extra_information youtube_id
      base_code capacity flyer_color
      price material_price amount material_amount
      kind
      status
      kind
      number_of_past_events
      is_public_price additional_facility_fee
    ],
    tag_ids: [],
    recreation_profile_attributes: %i[profile_id recreation_id],
    recreation_images_attributes: %i[id recreation_id image kind _destroy],
    recreation_prefectures_attributes: %i[id recreation_id name _destroy]
  )
  actions :all

  filter :title
  filter :second_title
  filter :minutes
  filter :price
  filter :status

  before_save do |recreation|
    recreation.recreation_images.each do |recreation_image|
      recreation_image.document_kind = recreation_image.kind_value
    end
  end

  csv do
    column :id
    column(:user, &:user_username)
    column(:user_email, &:user_email)
    column :title
    column :minutes
    column :second_title
    column :category
    column(:kind, &:kind_text)
    column(:status, &:status_text)
    column(:prefecture) { |recreation| recreation.recreation_prefectures.map(&:name).join(',') }
    column :flow_of_day
    column :description
    column :memo
    column :extra_information
    column :flyer_color
    column :price
    column :is_public_price
    column :amount
    column :material_amount
    column :material_price
    column :base_code
    column :additional_facility_fee
    column :bring_your_own_item
    column :borrow_item
    column :capacity
    column :number_of_past_events
    column :created_at
    column :updated_at
    column :youtube_id
  end

  index do
    id_column
    column :user
    column :title
    column :second_title
    column(:kind, &:kind_text)
    column(:category, &:category_text)
    column(:status, &:status_text)
    column :minutes
    column :price
    column :number_of_past_events
    column :is_public_price

    actions
  end

  show do
    tabs do
      tab '詳細' do
        attributes_table do
          row :id
          row :user
          row :title
          row :second_title
          row(:kind, &:kind_text)
          row(:category, &:category_text)
          row(:status, &:status_text)
          row :minutes
          row :description
          row :flow_of_day
          row :borrow_item
          row :bring_your_own_item
          row :extra_information
          row :youtube_id
          row :base_code
          row :capacity
          row :flyer_color
          row :price
          row :number_of_past_events
          row :material_price
          row :amount
          row :material_amount
          row :additional_facility_fee

          panel t('activerecord.models.profile'), style: 'margin-top: 30px;' do
            table_for recreation.profile do
              column :id
              column :name
              column :title
              column :position
              column('URL') do |profile|
                if profile.present?
                  link_to 'URL', admin_profile_path(profile)
                else
                  'プロフィールなし'
                end
              end
            end
          end

          row :is_withholding_tax
          row :is_public_price
          row :memo

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

        panel t('activerecord.models.recreation_prefecture'), style: 'margin-top: 30px;' do
          table_for recreation.recreation_prefectures do
            column(:name)
          end
        end
      end

      tab 'メモ' do
        render 'admin/recreations/memo', recreation:
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
      f.input :base_code
      f.input :capacity
      f.input :flyer_color, as: :string
      f.input :price
      f.input :number_of_past_events
      f.input :material_price
      f.input :amount
      f.input :material_amount
      f.input :is_public_price
      f.input :additional_facility_fee, hint: 'エブリ・プラス取り分の1000円 + パートナー支払い分の合計を入力してください'

      if f.object.id.present?
        li class: 'input' do
          content_tag(:label, Order.human_attribute_name(:is_withholding_tax), class: 'label', style: 'padding-top: 0px;') +
          f.check_box_tag('order[is_withholding_tax]', '1', f.object.is_withholding_tax)
        end

        div style: 'display: flex; justify-content: center;' do
          image_tag '/recreations/flow_is_withholding_tax.png', width: 800
        end
      end
    end

    f.inputs '', for: [:recreation_profile, f.object.recreation_profile || recreation.build_recreation_profile] do |p|
      # TODO(okubo): userに紐づくprofileのみに変更したい
      if f.object.id.nil?
        p.input :profile_id, as: :select, collection: Profile.all.map { |profile| [profile.name, profile.id] }
      else
        p.input :profile_id, as: :select, collection: recreation.user.profiles.map { |profile| [profile.name, profile.id] }
      end
      p.input :recreation_id, as: :hidden, input_html: { value: recreation.id }
    end

    f.input :kind, as: :select, collection: Recreation.kind.values.map { |val| [val.text, val] }
    f.input :category, as: :select, collection: Recreation.category.values.map { |val| [val.text, val] }
    f.input :status, as: :select, collection: Recreation.status.values.map { |val| [val.text, val] }
    f.input :tags, label: 'タグ', as: :check_boxes, collection: Tag.events.all
    f.input :tags, label: '想定ターゲット', as: :check_boxes, collection: Tag.targets.all

    f.inputs t('enumerize.recreation_image.kind.slider') do
      f.has_many :recreation_images, heading: false, allow_destroy: true, new_record: true do |ff|
        ff.input :image, as: :file, hint: image_tag(ff.object.image.to_s, width: 100)
        ff.input :kind, as: :select, collection: RecreationImage.kind.values.map { |i| [i.text, i] }
      end
    end
    f.inputs t('activerecord.models.recreation_prefecture') do
      f.has_many :recreation_prefectures, heading: false, allow_destroy: true, new_record: true do |ff|
        ff.input :name, as: :select, collection: RecreationPrefecture.names
      end
    end

    f.input :memo

    f.actions
  end
end
# rubocop:enable Metrics/BlockLength
