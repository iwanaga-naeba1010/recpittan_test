# frozen_string_literal: true

# NOTE: 日本語にするとバグる
ActiveAdmin.register User, as: 'Partner' do
  permit_params(
    %i[email role],
    partner_attributes: [:name, :title, :description, :image],
  )
  actions :all, except: [:destroy]

  scope 'Partner', default: true do |users|
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

    panel I18n.t('activerecord.models.partner'), style: 'margin-top: 30px;' do
      attributes_table_for partner.partner do
        row :name
        row :title
        row :description

        row t('activerecord.attributes.partner.image') do |user|
          image_tag user&.image&.to_s, width: 50, height: 50
        end
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :email
      f.input :role, as: :select, collection: User.role.values.map { |i| [i.text, i] }

      f.inputs I18n.t('activerecord.models.partner'), for: [:partner, f.object.partner || Partner.new({ user_id: f.object.id })] do |ff|
        ff.input :name
        ff.input :title
        ff.input :description
        ff.input :image
      end
    end

    f.actions
  end
end
