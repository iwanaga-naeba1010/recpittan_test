# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register InvoiceInformation do
  permit_params { InvoiceInformation.attribute_names.map(&:to_sym) }
  actions :all
  filter :id
  filter :user
  filter :name

  index do
    id_column
    column :user_id
    column :name
    column :code
    column :zip
    column :prefecture
    column :city
    column :street
    column :building
    column :memo

    actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :name
      row :code
      row :zip
      row :prefecture
      row :city
      row :street
      row :building
      row :memo

      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      # pertnerのみ表示
      f.input :user_id,
              label: 'ユーザー/施設名',
              as: :select,
              collection: User.where(
                role: :customer
              ).map { |customer| ["#{customer.username}/#{customer.company.facility_name}", customer.id] },
              input_html: { class: 'select2' }
      f.input :name
      f.input :code
      f.input :zip
      f.input :prefecture
      f.input :city
      f.input :street
      f.input :building
      f.input :memo
    end

    f.actions
  end
end
# rubocop:enable Metrics/BlockLength
