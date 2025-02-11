# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Orders::ForceWaitingForAnEventToTakePlace do
  permit_params(%i[start_at])

  actions :all, except: %i[new create destroy]
  menu parent: '強制執行モード'

  filter :user, collection: proc { User.includes(:company).customers.map { |i| [i.company&.facility_name, i.id] } }
  filter :recreation
  filter :status, collection: proc { Order.status.values.map { |i| [i.text, i.value] } }

  index do
    id_column
    column(:user) { |order| link_to order.user.company.facility_name, admin_company_path(order.user.company.id) }
    column :recreation
    column :start_at
    column(:status, &:status_text)

    actions
  end

  show do
    attributes_table do
      row :id
      row(:status, &:status_text)
      row(:user) { |order| link_to order.user.company.facility_name, admin_company_path(order.user.company.id) }
      row :recreation
      row :zip
      row :prefecture
      row :city
      row :street
      row :building
      row :number_of_people
      row :number_of_facilities
      row :is_accepted
      row :start_at
      row :end_at
      row :price
      row :amount
      row :material_price
      row :material_amount
      row :additional_facility_fee
      row :transportation_expenses
      row :expenses
      row :support_price
      row :contract_number

      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :start_at,
              as: :date_time_picker,
              input_html: { disabled: f.object.start_at.present? },
              hint: '5分単位の時間はformに直接入力してください'
    end

    f.actions
  end

  controller do
    def update
      order = Order.find(params[:id].to_i)

      order.update(
        start_at: permitted_params[:orders_force_waiting_for_an_event_to_take_place][:start_at],
        is_accepted: true
      )

      redirect_to admin_order_path(order.id)
    end
  end
end
# rubocop:enable Metrics/BlockLength
