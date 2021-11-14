# frozen_string_literal: true

# NOTE: 日本語にするとバグる
ActiveAdmin.register Partner do
  menu priority: 3
  permit_params(
    %i[name title description image],
    user_attributes: %i[email role]
  )
  actions :all, except: [:destroy]

  index do
    id_column
    column :name
    column :title
    column t('activerecord.attributes.partner.image') do |partner|
      image_tag partner.image.to_s, width: 50, height: 50
    end

    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row t('activerecord.attributes.partner.image') do |partner|
        image_tag partner.image.to_s, width: 50, height: 50
      end

      row :created_at
      row :updated_at
    end

    panel I18n.t('activerecord.models.user'), style: 'margin-top: 30px;' do
      attributes_table_for partner.user do
        row :email
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :title
      f.input :image, as: :file, hint: image_tag(f.object.image.to_s, width: 100)

      f.inputs I18n.t('activerecord.models.user'), for: [:user, f.object.user || User.new] do |ff|
        # TODO: emailの確認メール必要かも。
        # TODO: あと変更するとエラーメッセージも出ないので、最初からdisableからhint入れておくと良いかも
        ff.input :email
        # TODO: roleが正常に入っていない可能性あり
        ff.input :role, as: :hidden, value: :partner
      end
    end

    f.actions
  end
end
