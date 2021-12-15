# frozen_string_literal: true

ActiveAdmin.register Order do
  includes :user

  permit_params(
    %i[
      user_id recreation_id zip prefecture city street building number_of_people status
      is_accepted date_and_time transportation_expenses expenses
    ],
    )
  actions :all, except: [:destroy]

  index do
    id_column
    column :user
    column :recreation

    actions
  end

  show do
    tabs do
      tab '詳細' do
        attributes_table do
          row :id
          row(:status) {|rec| rec.status_text}
          row :user
          row :recreation
          row :zip
          row :prefecture
          row :city
          row :street
          row :building
          row :number_of_people
          row :is_accepted
          row :date_and_time
          row :transportation_expenses
          row :expenses

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

    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :user,
              as: :select,
              collection: User.includes(:company).customers.map { |i| [i.company&.name, i.id] },
              input_html: { class: 'select2' }
      f.input :recreation,
              input_html: { class: 'select2' }
      f.input :zip
      f.input :prefecture
      f.input :city
      f.input :street
      f.input :building
      f.input :number_of_people
      f.input :status, as: :select, collection: Order.status.values.map { |i| [i.text, i] }
      f.input :is_accepted
      f.input :date_and_time, as: :date_time_picker
      f.input :transportation_expenses
      f.input :expenses
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
      order.save
      redirect_to admin_order_path(order.id)
    end
  end
end
