# frozen_string_literal: true

ActiveAdmin.register Order do
  permit_params(
    %i[user_id recreation_id prefecture city number_of_people order_type],
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
      row :user
      row :recreation
      row :prefecture
      row :city
      row :number_of_people
      row :order_type

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
      f.input :user
      f.input :recreation
      f.input :prefecture
      f.input :city
      f.input :number_of_people
      f.input :order_type, as: :select, collection: Order.order_type.values.map { |i| [i.text, i] }
    end

    f.actions
  end
end
