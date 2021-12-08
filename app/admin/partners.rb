# frozen_string_literal: true

# NOTE: 日本語にするとバグる
ActiveAdmin.register Partner do
  menu priority: 3
  permit_params(
    %i[username username_kana role email]
  )
  actions :all

  index do
    id_column
    column :username
    column :username_kana
    column :email

    actions
  end

  show do
    attributes_table do
      row :id
      row :username
      row :username_kana
      row :username_kana

      row :created_at
      row :updated_at
    end

    panel I18n.t('activerecord.models.recreation'), style: 'margin-top: 30px;' do
      attributes_table_for partner.recreations do
        row :id
        row :title do |rec|
          link_to '詳細', admin_recreation_path(rec.id)
        end
      end
    end

  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :username
      f.input :username_kana

      if f.object&.id.present?
        f.input :email, hint: 'データの競合を避けるために許可していません。システム管理者にご連絡ください', input_html: { disabled: true }
      else
        f.input :email
      end

      f.input :role, as: :hidden, input_html: { value: :partner }
    end

    f.actions
  end

  controller do
    def create
      password = [*'A'..'Z', *'a'..'z', *0..9].sample(16).join

      partner = User.new(permitted_params[:partner])
      partner.email = permitted_params[:partner]['email']
      partner.password = password
      partner.confirmation_token = password
      partner.role = :partner
      partner.skip_confirmation_notification!
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
