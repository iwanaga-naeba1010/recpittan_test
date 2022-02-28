# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Partner do
  menu priority: 3
  permit_params(
    %i[username username_kana role email]
  )
  actions :all

  filter :id
  filter :username
  filter :email

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
      row :email

      row :created_at
      row :updated_at
    end

    panel I18n.t('activerecord.models.recreation'), style: 'margin-top: 30px;' do
      attributes_table_for partner.recreations do
        row :id
        row :title do |rec|
          link_to rec.title, admin_recreation_path(rec.id)
        end
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :username
      f.input :username_kana
      f.input :email
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
      partner.confirmed_at = Time.current
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

    def update
      partner = Partner.find(params[:id].to_i)
      if permitted_params[:partner][:password].blank?
        %w[password password_confirmation].each { |p| permitted_params[:partner].delete(p) }
      end
      partner.skip_confirmation_notification!
      # partner.skip_confirmation!
      partner.skip_reconfirmation!

      if partner.update_without_password(permitted_params[:partner])
        redirect_to admin_partner_path(partner.id)
      else
        # HACK: superを毎回呼ぶとcompany.createがダブルっぽいので、失敗した時のrenderのためにsuper入れる。
        # ちなみにrender :newは機能しない
        super
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
