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
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :username
      f.input :username_kana
      f.input :email # TODO: ここはdisableで
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
