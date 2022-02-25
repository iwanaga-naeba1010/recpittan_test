# frozen_string_literal: true

ActiveAdmin.register EmailTemplate do
  permit_params(%i[explanation title body signature])
  actions :all

  index do
    id_column
    column :title

    actions
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :explanation
      f.input :title
      f.input :body
      f.input :signature
    end

    f.actions
  end
end
