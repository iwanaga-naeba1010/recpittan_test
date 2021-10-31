# frozen_string_literal: true

ActiveAdmin.register Tag do
  permit_params(%i[name kind text image])
  actions :all, except: [:destroy]

  # TODO: filterの設定がなぜかうまういかない
  filter :kind, as: :select, collection: Tag.kind.values.map { |i| [i.text, i] }

  index do
    id_column
    column :name
    column :kind_text

    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :kind_text
      row :text
      row t('activerecord.attributes.tag.image') do |tag|
        image_tag tag&.image&.to_s, width: 50, height: 50
      end
      row :image
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :kind, as: :select, collection: Tag.kind.values.map { |i| [i.text, i] }
      f.input :name
      f.input :text
      f.input :image
    end

    f.actions
  end
end
