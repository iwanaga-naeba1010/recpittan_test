# frozen_string_literal: true

# NOTE: 日本語にするとバグる
ActiveAdmin.register Company do
  menu priority: 2
  permit_params(
    :name, :facility_name, :person_in_charge_name, :person_in_charge_name_kana,
    :zip, :prefecture, :city, :street, :building, :tel
  )

  actions :all, except: [:destroy]

  index do
    id_column
    column :name
    column :facility_name
    column :person_in_charge_name
    column :person_in_charge_name_kana
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :facility_name
      row :person_in_charge_name
      row :person_in_charge_name_kana
      row :zip
      row :city
      row :street
      row :building
      row :tel
      row :prefecture
      row :created_at
      row :updated_at
    end

    panel I18n.t('activerecord.models.user'), style: 'margin-top: 30px;' do
      attributes_table_for company.users do
        row :email
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :facility_name
      f.input :person_in_charge_name
      f.input :person_in_charge_name_kana
      f.input :zip
      f.input :city
      f.input :street
      f.input :tel

    #   f.inputs I18n.t('activerecord.models.company'), for: [:company, f.object.company || Company.new({ user_id: f.object.id })] do |ff|
    #     ff.input :name
    #     ff.input :facility_name
    #     ff.input :person_in_charge_name
    #     ff.input :person_in_charge_name_kana
    #     ff.input :zip
    #     ff.input :prefecture
    #     ff.input :city
    #     ff.input :street
    #     ff.input :building
    #     ff.input :tel
    #   end
    end

    f.actions
  end
end
