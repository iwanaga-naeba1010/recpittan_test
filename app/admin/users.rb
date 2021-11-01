# frozen_string_literal: true

# NOTE: 日本語にするとバグる
ActiveAdmin.register User, as: 'Company' do
  permit_params(
    %i[email role],
    company_attributes: [:name, :facility_name, :person_in_charge_name, :person_in_charge_name_kana],
  )
  actions :all, except: [:destroy]

  scope 'User', default: true do |users|
    users.where(role: :user)
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
      end
    end

    f.actions
  end
end
