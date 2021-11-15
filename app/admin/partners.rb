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

        if ff.object.id.present?
          ff.input :email, input_html: { disabled: true }, hint: 'ユーザーのEmail保護の観点から管理画面からは操作できません。システム責任者にご連絡ください。'
        else
          ff.input :email
        end
      end
    end

    f.actions
  end

  controller do
    def create
      password = [*'A'..'Z', *'a'..'z', *0..9].sample(16).join

      partner = Partner.new(permitted_params[:partner])
      partner.user.email = permitted_params[:partner].to_h[:user_attributes]['email']
      partner.user.password = password
      partner.user.confirmation_token = password
      partner.user.role = :partner
      partner.user.skip_confirmation_notification!
      # TODO: 招待メールを送信
      # UserMailer.with(user: @user, password: password).invite.deliver_now

      if partner.save
        redirect_to admin_partner_path(partner.id)
      else
        # HACK: superを毎回呼ぶとcompany.createがダブルっぽいので、失敗した時のrenderのためにsuper入れる。
        # ちなみにrender :newは機能しない
        super
      end
    end
  end
end
