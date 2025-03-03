# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Partner do
  permit_params(
    :username, :username_kana, :email, :password, :password_confirmation,
    :role, :approval_status, :memo, :manage_company_code,
    partner_info_attributes: %i[
      id
      company_name
      postal_code
      prefecture
      city
      address1
      address2
      phone_number
    ],
    bank_account_attributes: %i[
      id
      is_corporate
      corporate_type_code
      is_foreignresident
      investments
      is_invoice
      invoice_number
      corporate_number
      bank_name
      branch_code
      branch_name
      bank_code
      account_type
      account_number
      account_holder_name
    ]
  )

  filter :id
  filter :username
  filter :email
  filter :manage_company_code, as: :select, collection: Partner.manage_company_code.values.map { |i| [i.text, i] }

  index do
    id_column
    column :username
    column :username_kana
    column :email
    column(:manage_company_code, &:manage_company_code_text)
    column(:approval_status, &:approval_status_text)
    column :memo

    actions
  end

  show do
    profiles     = partner.profiles
    partner_info = partner.partner_info
    bank_account = partner.bank_account

    tabs do
      tab '詳細' do
        panel 'パートナーの詳細', class: 'panel-partner-details' do
          if profiles.present?
            panel 'プロフィール情報', class: 'sub-panel' do
              profiles.each do |p|
                div class: 'link' do
                  link_to p.name, admin_profile_path(p.id)
                end
              end
            end
          end

          div class: 'sub-panel' do
            attributes_table title: 'パートナー登録情報' do
              row :id
              row :username
              row :username_kana
              row :email, class: 'text-blue-light'
              row(:role, &:role_text)
              row(:approval_status, &:approval_status_text)
              row(:manage_company_code, &:manage_company_code_text)
              row :memo

              row :created_at
              row :updated_at
            end
          end

          if partner_info.present?
            panel 'パートナー情報', class: 'sub-panel' do
              attributes_table_for partner_info do
                row :user_id
                row :company_name
                row :postal_code
                row :prefecture
                row :city
                row :address1
                row :address2
                row :phone_number

                row :created_at
                row :updated_at
              end
            end
          end

          if bank_account.present?
            panel '口座・法人情報', class: 'sub-panel' do
              attributes_table_for bank_account do
                row :is_corporate
                row :corporate_type_code
                row :is_foreignresident
                row :investments
                row :is_invoice
                row :invoice_number
                row :corporate_number
                row :bank_name
                row :bank_code
                row :branch_name
                row :branch_code
                row(:account_type, &:account_type_text)
                row :account_number
                row :account_holder_name
              end
            end
          end
        end
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs 'パートナー登録情報' do
      f.input :username
      f.input :username_kana
      f.input :email
      f.input :password if f.object.new_record?
      f.input :password_confirmation if f.object.new_record?
      f.input :role, as: :select, collection: Partner.role.values.map { |i| [i.text, i] }
      f.input :approval_status, as: :select, collection: Partner.approval_status.values.map { |i| [i.text, i] }
      f.input :memo
      f.input :manage_company_code, as: :select, collection: Partner.manage_company_code.values.map { |i| [i.text, i] }
    end

    f.inputs 'パートナー情報' do
      f.object.build_partner_info if f.object.partner_info.blank?
      f.semantic_fields_for :partner_info do |ff|
        ff.input :id, as: :hidden
        ff.input :company_name
        ff.input :postal_code
        ff.input :prefecture
        ff.input :city
        ff.input :address1
        ff.input :address2
        ff.input :phone_number
      end
    end

    f.inputs '口座・法人情報' do
      f.object.build_bank_account if f.object.bank_account.blank?
      f.semantic_fields_for :bank_account do |ff|
        ff.input :id, as: :hidden
        ff.input :is_corporate, as: :select, collection: [['法人', true], ['個人', false]]
        ff.input :corporate_type_code, as: :select, collection: Division.pluck(:classname, :code)
        ff.input :is_foreignresident, as: :select, collection: [['-', false], ['海外在住', true]]
        ff.input :investments
        ff.input :is_invoice, as: :select, collection: [['免税', false], ['登録済み', true]]
        ff.input :invoice_number, as: :string
        ff.input :corporate_number, as: :string
        ff.input :bank_name
        ff.input :bank_code
        ff.input :branch_name
        ff.input :branch_code
        ff.input :account_type
        ff.input :account_number
        ff.input :account_holder_name
      end
    end

    f.actions
  end

  controller do
    def create
      # password = [*'A'..'Z', *'a'..'z', *0..9].sample(16).join

      partner = Partner.new(permitted_params[:partner])
      partner.email = permitted_params[:partner]['email']
      # partner.password = password
      # partner.confirmation_token = password
      partner.confirmed_at = Time.current
      partner.role = permitted_params[:partner]['role']
      partner.skip_confirmation_notification!

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
