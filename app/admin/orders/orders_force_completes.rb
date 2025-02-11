# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Orders::ForceComplete do
  permit_params(%i[kind name])

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
    end

    f.actions
  end

  controller do
    def update
      order = Order.find(params[:id].to_i)
      evaluation = order.create_report(
        number_of_facilities: order.number_of_facilities,
        number_of_people: order.number_of_people,
        expenses: order.expenses,
        transportation_expenses: order.transportation_expenses,
        status: :accepted,
        body: 'システムの自動投稿'
      )

      evaluation.create_evaluation(
        message: 'システムの自動投稿',
        other_message: 'システムの自動投稿'
      )

      order.update(status: :finished)

      redirect_to admin_order_path(order.id)
    end
  end
end
# rubocop:enable Metrics/BlockLength
