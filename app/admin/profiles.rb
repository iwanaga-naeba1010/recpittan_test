# frozen_string_literal: true

ActiveAdmin.register Profile do
  permit_params { Profile.attribute_names.map(&:to_sym) }

  actions :all

  filter :user_id, as: :select, collection: -> { User.where(role: :partner).pluck(:username, :id) }, label: 'パートナー'
  filter :recreation, as: :select, collection: -> { Recreation.pluck(:title, :id) }, label: 'レク'
  filter :name
  filter :description
  filter :position
  filter :title

  index do
    id_column
    column :user
    column :name
    column :title

    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :name
      row :title
      row :position
      row(:image) do |profile|
        image_tag profile&.image&.to_s, width: 50, height: 50
      end
      row :description
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :user_id,
              label: 'パートナー',
              as: :select,
              collection: User.where(role: :partner).map { |partner| [partner.username, partner.id] }

      f.input :name
      f.input :title
      f.input :position
      f.input :description
      f.input :image
    end

    f.actions
  end
end
