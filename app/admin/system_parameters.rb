# frozen_string_literal: true

ActiveAdmin.register SystemParameter do
  permit_params(
    %i[
      param_code
      param_name
      value_int
      value_text
      applied_date
    ]
  )

  actions :all
  menu parent: 'システム管理'
  decorate_with SystemParameterDecorator

  index do
    id_column
    column :param_code
    column :param_name
    column :value_int
    column :value_text
    column(:applied_date, &:applied_date_formatted)

    actions
  end

  show do
    tabs do
      tab '詳細' do
        attributes_table do
          row :id
          row :param_code
          row :param_name
          row :value_int
          row :value_text
          row(:applied_date, &:applied_date_formatted)
        end
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :param_code
      f.input :param_name
      f.input :value_int
      f.input :value_text
      f.input :applied_date, as: :date_picker
    end

    f.actions
  end
end
