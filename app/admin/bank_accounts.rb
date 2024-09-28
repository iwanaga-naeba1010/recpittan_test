# frozen_string_literal: true

ActiveAdmin.register BankAccount do
  actions :index, :show

  filter :user
  filter :account_holder_name

  csv do
    column :id
    column('PT名', &:user_username)
    column :bank_name
    column :bank_code
    column :branch_name
    column :branch_code
    column(:account_type, &:account_type_text)
    column :account_number
    column :account_holder_name
    column :created_at
    column :updated_at
  end

  index do
    id_column
    column :user
    column :bank_name
    column :bank_code
    column :branch_name
    column :branch_code
    column(:account_type, &:account_type_text)
    column :account_number
    column :account_holder_name
    column :created_at
    column :updated_at

    actions
  end

  show do
    tabs do
      tab '詳細' do
        attributes_table do
          row :id
          row :user
          row :bank_name
          row :bank_code
          row :branch_name
          row :branch_code
          row(:account_type, &:account_type_text)
          row :account_number
          row :account_holder_name
          row :created_at
          row :updated_at
        end
      end
    end
  end
end
