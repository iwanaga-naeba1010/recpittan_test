# frozen_string_literal: true

# NOTE: 日本語にするとバグる
# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Company do
  menu priority: 2
  permit_params(
    :name, :facility_name, :person_in_charge_name, :person_in_charge_name_kana,
    :zip, :prefecture, :city, :street, :building, :tel,
    plan_attributes: %i[id company_id kind _destroy],
    user_attributes: %i[id email]
  )

  actions :all, except: [:destroy]

  filter :id
  filter :name
  filter :facility_name
  filter :person_in_charge_name
  filter :zip
  filter :prefecture

  index do
    id_column
    column :name
    column :facility_name
    column :person_in_charge_name
    column :person_in_charge_name_kana
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :facility_name
      row :person_in_charge_name
      row :person_in_charge_name_kana
      row :zip
      row :city
      row :street
      row :building
      row :tel
      row :prefecture
      row :created_at
      row :updated_at
    end

    panel I18n.t('activerecord.models.user'), style: 'margin-top: 30px;' do
      attributes_table_for company.user do
        row :email
      end
    end

    panel I18n.t('activerecord.models.plan'), style: 'margin-top: 30px;' do
      attributes_table_for company.plan do
        row :kind_text
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :facility_name
      f.input :person_in_charge_name
      f.input :person_in_charge_name_kana
      f.input :zip
      f.input :prefecture
      f.input :city
      f.input :street
      f.input :building
      f.input :tel

      f.inputs I18n.t('activerecord.models.plan'), for: [:plan, f.object.plan || Plan.new({ company_id: f.object.id })] do |ff|
        ff.input :kind, as: :select, collection: Plan.kind.values.map { |i| [i.text, i] }
      end

      f.inputs I18n.t('activerecord.models.user'), for: [:user, f.object.user || User.new({ company_id: f.object.id })] do |ff|
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

      company = Company.new(permitted_params[:company])
      company.user.email = permitted_params[:company].to_h[:user_attributes]['email']
      company.user.password = password
      company.user.confirmation_token = password
      company.user.confirmed_at = Time.current
      company.user.skip_confirmation_notification!
      # TODO: 招待メールを送信
      # UserMailer.with(user: @user, password: password).invite.deliver_now

      if company.save
        redirect_to admin_company_path(company.id)
      else
        # HACK: superを毎回呼ぶとcompany.createがダブルっぽいので、失敗した時のrenderのためにsuper入れる。
        # ちなみにrender :newは機能しない
        super
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
