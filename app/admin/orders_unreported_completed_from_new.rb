# frozen_string_literal: true

ActiveAdmin.register Orders::UnreportedCompletedFromNew do
  permit_params(
    %i[
      user_id recreation_id zip prefecture city street building number_of_people
      number_of_facilities status is_accepted start_at end_at
      regular_price instructor_amount regular_material_price instructor_material_amount
      additional_facility_fee transportation_expenses support_price expenses
      zoom_price contract_number
    ]
  )

  actions :all, except: %i[show edit update destroy]
  menu parent: '強制執行モード'

  index do
    id_column
    actions
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :user,
              as: :select,
              collection: User.includes(:company).customers.map { |i| [i.company&.facility_name, i.id] },
              input_html: { class: 'select2' }
      f.input :recreation, input_html: { class: 'select2' }
      f.input :zip
      f.input :prefecture
      f.input :city
      f.input :street
      f.input :building
      f.input :number_of_people
      f.input :number_of_facilities

      f.input :regular_price
      f.input :instructor_amount
      f.input :regular_material_price
      f.input :instructor_material_amount
      f.input :additional_facility_fee
      f.input :transportation_expenses
      f.input :expenses
      f.input :zoom_price
      f.input :support_price

      f.input :start_at, as: :hidden, input_html: { value: Date.yesterday }
      f.input :end_at, as: :hidden, input_html: { value: Date.yesterday }
      f.input :is_accepted, as: :hidden, input_html: { value: true }
    end

    f.actions
  end

  controller do
    def create
      order = Order.new(permitted_params[:orders_unreported_completed_from_new])
      order.save
      redirect_to admin_order_path(order.id)
    end
  end
end
