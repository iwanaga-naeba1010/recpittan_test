# frozen_string_literal: true

ActiveAdmin.register Tag do
  permit_params(%i[name kind])
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
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :kind, as: :select, collection: Tag.kind.values.map { |i| [i.text, i] }
    end

    f.actions
  end
end
