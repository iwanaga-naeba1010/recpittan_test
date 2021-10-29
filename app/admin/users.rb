# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params(%i[email name role])
  actions :all, except: [:destroy]

  index do
    id_column
    column :email
    column :role
    column :name
    column :name_kana
    column :company_name
    column :facility_name

    actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :role
      row :name
      row :name_kana
      row :company_name
      row :facility_name
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :email
      f.input :role, as: :select, collection: User.role.values.map { |i| [i.text, i] }
      f.input :name
      f.input :name_kana
      f.input :company_name
      f.input :facility_name
    end

    f.actions
  end
end
