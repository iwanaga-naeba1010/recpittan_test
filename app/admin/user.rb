# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register User do
  menu priority: 3
  permit_params(
    %i[username username_kana role email password password_confirmation memo approval_status manage_company_code]
  )
  actions :all

  filter :id
  filter :username
  filter :email
  filter :role, as: :select, collection: User.role.values.map { |v| [v.text, v.value] }
  filter :company, label: 'Company', as: :select, collection: -> {
                                                                Company.pluck(:name, :id).map do |company|
                                                                  ["#{company[0]} (ID: #{company[1]})", company[1]]
                                                                end
                                                              }

  index do
    id_column
    column :username
    column :username_kana
    column :email
    column(:manage_company_code, &:manage_company_code_text)
    column(:role, &:role_text)
    column(:approval_status, &:approval_status_text)
    column :memo

    actions
  end

  show do
    tabs do
      tab '詳細' do
        attributes_table do
          row :username
          row :username_kana
          row :email
          row(:manage_company_code, &:manage_company_code_text)
          row(:role, &:role_text)
          row(:approval_status, &:approval_status_text) if user.role == 'partner'
          row :company if user.role == 'customer'
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
      f.input :manage_company_code, as: :select, collection: User.manage_company_code.values.map { |i| [i.text, i] }
      f.input :password, required: f.object.new_record?
      f.input :password_confirmation
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
      approval_status_was = user.approval_status

      if permitted_params[:user][:password].blank?
        %w[password password_confirmation].each { |p| permitted_params[:user].delete(p) }
      end
      user.skip_confirmation_notification!
      # partner.skip_confirmation!
      user.skip_reconfirmation!

      return super unless user.update_without_current_password(permitted_params[:user])

      if user.approval_status.approved? && approval_status_was != user.approval_status
        Rails.logger.info "User changed approval status: #{user.id} - #{user.username}"
      end

      redirect_to admin_user_path(user.id)
    end
  end
end
# rubocop:enable Metrics/BlockLength
