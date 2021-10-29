# frozen_string_literal: true

ActiveAdmin.register Recreation do
  permit_params(
    %i[user_id title second_title minutes description flow_of_day borrow_item bring_your_own_item extra_information],
    recreation_tags_attributes: %i[id tag_id _destroy],
    recreation_targets_attributes: %i[id target_id _destroy],
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

    panel t('activerecord.models.tag'), style: 'margin-top: 30px;' do
      table_for recreation.tags do
        column :id
        column :name
      end
    end

    panel t('activerecord.models.target'), style: 'margin-top: 30px;' do
      table_for recreation.targets do
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

    f.inputs t('activerecord.models.tag') do
      f.has_many :recreation_tags, heading: false, allow_destroy: true, new_record: true do |t|
        t.input :tag_id, as: :select, collection: Tag.all
      end
    end

    f.inputs t('activerecord.models.target') do
      f.has_many :recreation_targets, heading: false, allow_destroy: true, new_record: true do |t|
        t.input :target_id, as: :select, collection: Target.all
      end
    end

    f.actions
  end
end
