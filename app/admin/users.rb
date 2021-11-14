# frozen_string_literal: true

# NOTE: 日本語にするとバグる
ActiveAdmin.register User do
  menu priority: 2
  permit_params(
    %i[email role],
    company_attributes: [
      :name, :facility_name, :person_in_charge_name, :person_in_charge_name_kana,
      :zip, :prefecture, :city, :street, :building, :tel
    ]
  )

  actions :all, except: [:destroy]

  scope '施設', default: true do |users|
    users.where(role: :customer)
  end

  scope 'パートナー' do |users|
    users.where(role: :partner)
  end

  index do
    id_column
    column :email
    column :role
    actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :role
      row :created_at
      row :updated_at
    end

    panel I18n.t('activerecord.models.company'), style: 'margin-top: 30px;' do
      attributes_table_for company.company do
        row :name
        row :facility_name
        row :person_in_charge_name
        row :person_in_charge_name_kana
        row :zip
        row :prefecture
        row :city
        row :street
        row :building
        row :tel
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :email
      f.input :role, as: :select, collection: User.role.values.map { |i| [i.text, i] }

      f.inputs I18n.t('activerecord.models.company'), for: [:company, f.object.company || Company.new({ user_id: f.object.id })] do |ff|
        ff.input :name
        ff.input :facility_name
        ff.input :person_in_charge_name
        ff.input :person_in_charge_name_kana
        ff.input :zip
        ff.input :prefecture
        ff.input :city
        ff.input :street
        ff.input :building
        ff.input :tel
      end
    end

    f.actions
  end
end
