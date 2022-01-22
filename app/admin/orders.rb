# frozen_string_literal: true

ActiveAdmin.register Order do
  includes :user

  permit_params(
    %i[
      user_id recreation_id zip prefecture city street building number_of_people
      number_of_facilities status is_accepted start_at end_at
      regular_price instructor_amount regular_material_price instructor_material_amount
      additional_facility_fee transportation_expenses support_price expenses
      zoom_price contract_number
    ]
  )
  actions :all

  filter :user, collection: proc { User.includes(:company).customers.map { |i| [i.company&.facility_name, i.id] } }
  filter :recreation
  filter :status, collection: proc { Order.status.values.map { |i| [i.text, i.value] } }

  csv do
    column :id
    column(:status, &:status_text)
    column(:user) { |order| order.user.company.facility_name }
    column(:recreation, &:recreation_title)
    column :zip
    column :prefecture
    column :city
    column :street
    column :building
    column :number_of_people
    column :number_of_facilities
    column :is_accepted
    column :start_at
    column :end_at
    column :regular_price
    column :instructor_amount
    column :regular_material_price
    column :instructor_material_amount
    column :additional_facility_fee
    column :transportation_expenses
    column :expenses
    column :support_price
    column :zoom_price
    column :contract_number
    column('パートナー支払額', &:total_price_for_partner)
    column('施設請求額', &:total_price_for_customer)
  end

  index do
    id_column
    column(:user) { |order| link_to order.user.company.facility_name, admin_company_path(order.user.company.id) }
    column :recreation
    column :start_at
    column(:status, &:status_text)

    actions
  end

  show do
    tabs do
      tab '詳細' do
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
          row :number_of_facilitiese
          row :is_accepted
          row :start_at
          row :end_at
          row :regular_price
          row :instructor_amount
          row :regular_material_price
          row :instructor_material_amount
          row :additional_facility_fee
          row :transportation_expenses
          row :expenses
          row :support_price
          row :zoom_price
          row :contract_number

          row :created_at
          row :updated_at
        end

        panel '終了報告', style: 'margin-top: 30px;' do
          table_for order.report do
            column :id
            column :status
            column :number_of_facilities
            column :number_of_people
            column :expenses
            column :transportation_expenses
            column :body
          end
        end

        panel '評価', style: 'margin-top: 30px;' do
          table_for order.report&.evaluation do
            column(:communication) { |evaluation| evaluation&.communication_text }
            column(:ingenuity) { |evaluation| evaluation&.ingenuity_text }
            column(:price) { |evaluation| evaluation&.price_text }
            column(:smoothness) { |evaluation| evaluation&.smoothness_text }
            column(:want_to_order_agein) { |evaluation| evaluation&.want_to_order_agein_text }
            column :message
            column :other_message
          end
        end
      end

      tab 'メモ' do
        render 'admin/order_memo', order: order
      end

      tab 'チャット' do
        panel 'チャット', style: 'margin-top: 30px;' do
          render 'admin/chat', order: order
        end
      end

      tab '請求情報' do
        panel '施設請求額', style: 'margin-top: 30px;' do
          render 'admin/order_fee_table', order: order, kind: :customer
        end

        panel 'パートナー支払額', style: 'margin-top: 30px;' do
          render 'admin/order_fee_table', order: order, kind: :partner
        end
      end

    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :user,
              as: :select,
              collection: User.includes(:company).customers.map { |i| [i.company&.facility_name, i.id] },
              input_html: { class: 'select2' }
      f.input :recreation, input_html: { class: 'select2' }
      # NOTE(okubo): createは依頼だけなので必要な項目だけ表示
      # f.input :zip
      # f.input :prefecture
      # f.input :city
      # f.input :street
      # f.input :building
      # f.input :number_of_people
      # f.input :number_of_facilities
      # f.input :status, as: :select, collection: Order.status.values.map { |i| [i.text, i] }
      # f.input :is_accepted
      # f.input :start_at, as: :date_time_picker
      # f.input :end_at, as: :date_time_picker

      # f.input :regular_price
      # f.input :instructor_amount
      # f.input :regular_material_price
      # f.input :instructor_material_amount
      # f.input :additional_facility_fee
      f.input :support_price

      # f.input :transportation_expenses
      # f.input :expenses
      # f.input :zoom_price
      f.input :contract_number, hint: 'スプレッドシート管理のIDを紐づけるための項目です。将来的にシステムに移行しますが、現在は入力のみとなっております。'
    end

    f.actions
  end

  controller do
    def create
      # TODO: 人数など必要なカラムも入れる

      message = <<EOS
リクエスト内容
相談したい
希望日時
1.
2.
3.

希望人数
-人

介護度目安

住所

相談したい事

EOS

      order = Order.new(permitted_params[:order])
      order.chats.build(user_id: current_user.id, message: message)
      order.save!
      redirect_to admin_order_path(order.id)
    rescue StandardError => e
      Rails.logger.error e
      super
    end

    def update
      # NOTE: finished以降でreportと評価がなければ自動で追加する修正
      order = Order.find(params[:id].to_i)
      list = ['finished', 'invoice_issued', 'paid', 'canceled', 'travled']

      is_contains = list.map { |l| permitted_params[:order][:status]&.include?(l) }.compact.uniq.delete_if { |v| v==false }

      if is_contains&.first == true
        if order.report.blank?
          order.create_report(
            expenses: order.expenses,
            number_of_facilities: order.number_of_facilities,
            number_of_people: order.number_of_people,
            status: :accepted,
            transportation_expenses: order.transportation_expenses
          )
          order.report.create_evaluation(
            communication: 0,
            ingenuity: 0,
            price: 0,
            smoothness: 0,
            want_to_order_agein: 0,
            message: '管理画面からの自動入力です',
            other_message: '管理画面からの自動入力です'
          )
        end
      end

      order.update(permitted_params[:order])
      redirect_to admin_order_path(order.id)
    end
  end
end
