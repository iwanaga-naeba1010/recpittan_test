# frozen_string_literal: true

ActiveAdmin.register Recreation do
  permit_params(
    %i[user_id title second_title minutes description flow_of_day borrow_item bring_your_own_item extra_information],
    tag_ids: []
  )
  actions :all

  index do
    id_column
    column :user
    column :title
    column :second_title
    column :minutes

    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :title
      row :second_title
      row :minutes
      row :description
      row :flow_of_day
      row :borrow_item
      row :bring_your_own_item
      row :extra_information
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
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      # pertnerのみ表示
      f.input :user, as: :select, collection: User.where(role: :partner)
      f.input :title
      f.input :second_title
      f.input :minutes
      f.input :description
      f.input :flow_of_day
      f.input :borrow_item
      f.input :bring_your_own_item
      f.input :extra_information
    end

    f.input :tags, label: 'イベント種別', as: :check_boxes, collection: Tag.events.all
    f.input :tags, label: 'カテゴリー', as: :check_boxes, collection: Tag.categories.all
    f.input :tags, label: '想定ターゲット', as: :check_boxes, collection: Tag.targets.all

    f.actions
  end
end
