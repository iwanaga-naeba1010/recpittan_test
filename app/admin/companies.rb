# frozen_string_literal: true

# NOTE: 日本語にするとバグる
# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Company do
  menu priority: 2
  permit_params(
    :name, :facility_name, :facility_name_kana, :person_in_charge_name, :person_in_charge_name_kana,
    :zip, :prefecture, :city, :street, :building, :tel,
    :genre, :url, :feature, :capacity, :nursing_care_level, :request, :user_company_id, :memo,
    tag_ids: []
  )

  actions :all, except: [:destroy]

  filter :id
  filter :manage_company_code
  filter :name
  filter :facility_name
  filter :person_in_charge_name
  filter :zip
  filter :prefecture
  filter :user, collection: proc { User.customers.map { |i| [i.username, i.id] } }

  csv do
    column :id
    column :name
    column('email', &:user_email)
    column :facility_name
    column :facility_name_kana
    column :person_in_charge_name
    column :person_in_charge_name_kana
    column :zip
    column :prefecture
    column :city
    column :street
    column :building
    column :tel
    column(:genre, &:genre_text)
    column :url
    column :feature
    column :capacity
    column :nursing_care_level
    column :request
    column :memo
    column :created_at
    column :updated_at
  end

  index do
    id_column
    column :manage_company_code
    column :name
    column :facility_name
    column :facility_name_kana
    column :person_in_charge_name
    column :person_in_charge_name_kana
    actions
  end

  show do
    tabs do
      tab '詳細' do
        attributes_table do
          row :id
          row :name
          row :facility_name
          row :facility_name_kana
          row :person_in_charge_name
          row :person_in_charge_name_kana
          row :zip
          row :city
          row :street
          row :building
          row :tel
          row :prefecture
          row(:genre, &:genre_text)
          row :url
          row :feature
          row :capacity
          row :nursing_care_level
          row :request
          row :memo
          row :created_at
          row :updated_at
        end

        panel I18n.t('activerecord.models.user'), style: 'margin-top: 30px;' do
          attributes_table_for company.user do
            row :email
          end
        end
      end

      tab 'メモ' do
        render 'admin/companies/memo', company:
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :name
      f.input :facility_name
      f.input :facility_name_kana
      f.input :person_in_charge_name
      f.input :person_in_charge_name_kana
      f.input :zip
      f.input :prefecture
      f.input :city
      f.input :street
      f.input :building
      f.input :tel

      f.input :genre, as: :select, collection: Company.genre.values.map { |val| [val.text, val] }
      f.input :url
      f.input :feature
      f.input :capacity
      f.input :nursing_care_level

      f.input :tags, label: '貸出可能品', as: :check_boxes, collection: Tags::Rental.all
      f.input :user_company_id, as: :select, collection: User.customers.where(company_id: nil).map { |i| [i.username, i.id] }

      f.input :memo
    end

    f.actions
  end

  controller do
    def create
      company = Company.new(permitted_params[:company])
      user = User.find(company.user_company_id.to_i)

      company.save!
      user.update!(company_id: company.id)
      redirect_to admin_company_path(company.id)

      # NOTE(okubo): hashを検索するときにエラー出るので、cache入れてる
    rescue StandardError => e
      Sentry.capture_exception(e)
      logger.error e.message
      super
    end
  end

  controller do
    def update
      company = Company.find(params[:id])
      company.update!(permitted_params[:company])
      if permitted_params[:company][:user_company_id].present?
        user = User.find(permitted_params[:company][:user_company_id])
        user.update!(company_id: company.id)
        User.where(company_id: company.id).where.not(id: user.id).update(company_id: nil)
      end
      super
    end
  end
end
# rubocop:enable Metrics/BlockLength
