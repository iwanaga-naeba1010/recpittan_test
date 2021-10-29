# frozen_string_literal: true

ActiveAdmin.register Tag do
  permit_params(%i[name])
  actions :all, except: [:destroy]

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
      f.input :name
    end

    f.actions
  end
end
