# frozen_string_literal: true

ActiveAdmin.register Order do
  permit_params(
    %i[user_id recreation_id prefecture city number_of_people status is_online is_accepted date_and_time],
  )
  actions :all, except: [:destroy]

  index do
    id_column
    column :user
    column :recreation

    actions
  end

  show do
    attributes_table do
      row :id
      row :status
      row :user
      row :recreation
      row :prefecture
      row :city
      row :number_of_people
      row :is_online
      row :is_accepted
      row :date_and_time

      row :created_at
      row :updated_at
    end

    panel 'チャット', style: 'margin-top: 30px;' do
      render 'admin/chat', order: order
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :user, as: :select, collection: User.customers.map { |i| [i.company&.name, i.id] }

      f.input :recreation
      f.input :prefecture
      f.input :city
      f.input :number_of_people
      f.input :status, as: :select, collection: Order.status.values.map { |i| [i.text, i] }
      f.input :is_online
      f.input :is_accepted
      f.input :date_and_time
    end

    f.actions
  end
end
