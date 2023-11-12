# frozen_string_literal: true

ActiveAdmin.register Tags::Plan do
  permit_params(%i[name kind])
  actions :all
  menu parent: 'プランタグ'

  # TODO: filterの設定がなぜかうまういかない
  filter :kind, as: :select, collection: Tag.kind.values.map { |i| [i.text, i] }

  index do
    id_column
    column :name

    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :kind, as: :hidden, input_html: { value: :tag }
      f.input :name
    end

    f.actions
  end
end
