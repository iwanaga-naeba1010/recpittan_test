# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register User do
  menu priority: 3
  permit_params(
    %i[username username_kana role email password password_confirmation memo approval_status]
  )
  actions :all

  filter :id
  filter :username
  filter :email
  filter :role

  index do
    id_column
    column :username
    column :username_kana
    column :email
    column(:role, &:role_text)
    column(:approval_status, &:approval_status_text)
    column :memo

    actions
  end

  show do
    tabs do
      tab '詳細' do
        attributes_table do
          row :id
          row :username
          row :username_kana
          row :email
          row(:role, &:role_text)
          row(:approval_status, &:approval_status_text) if user.role == 'partner'
          row :memo

          row :created_at
          row :updated_at
        end
      end
      tab 'メモ' do
        render 'admin/users/memo', user:
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :username
      f.input :username_kana
      f.input :email
      f.input :password if f.object.new_record?
      f.input :password_confirmation if f.object.new_record?
      f.inputs do
        f.input :role, as: :select, collection: User.role.values.map { |i| [i.text, i] }
      end
      if user.role == 'partner'
        f.inputs do
          f.input :approval_status, as: :select, collection: User.approval_status.values.map { |i| [i.text, i] }
        end
      end
      f.input :memo
    end

    f.actions
  end

  controller do
    def create
      # password = [*'A'..'Z', *'a'..'z', *0..9].sample(16).join

      user = User.new(permitted_params[:user])
      user.email = permitted_params[:user]['email']
      # user.password = password
      # user.confirmation_token = password
      user.confirmed_at = Time.current
      user.role = permitted_params[:user]['role']
      user.skip_confirmation_notification!
      # TODO: 招待メールを送信
      # UserMailer.with(user: @user, password: password).invite.deliver_now

      if user.save
        redirect_to admin_user_path(user.id)
      else
        # HACK: superを毎回呼ぶとcompany.createがダブルっぽいので、失敗した時のrenderのためにsuper入れる。
        # ちなみにrender :newは機能しない
        super
      end
    end

    def update
      user = User.find(params[:id].to_i)
      if permitted_params[:user][:password].blank?
        %w[password password_confirmation].each { |p| permitted_params[:user].delete(p) }
      end
      user.skip_confirmation_notification!
      # partner.skip_confirmation!
      user.skip_reconfirmation!

      if user.update_without_password(permitted_params[:user])
        redirect_to admin_user_path(user.id)
      else
        # HACK: superを毎回呼ぶとcompany.createがダブルっぽいので、失敗した時のrenderのためにsuper入れる。
        # ちなみにrender :newは機能しない
        super
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
