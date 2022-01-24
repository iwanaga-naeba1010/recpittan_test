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
    ],
    report: {},
    evaluation: {}
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

      end

      tab 'メモ' do
        render 'admin/orders/memo', order: order
      end

      tab 'チャット' do
        panel 'チャット', style: 'margin-top: 30px;' do
          render 'admin/orders/chat', order: order
        end
      end

      tab '終了報告' do
        panel '終了報告', style: 'margin-top: 30px;' do
          render 'admin/orders/report', report: order&.report
        end
      end

      tab '請求情報' do
        panel '施設請求額', style: 'margin-top: 30px;' do
          render 'admin/orders/fee_table', order: order, kind: :customer
        end

        panel 'パートナー支払額', style: 'margin-top: 30px;' do
          render 'admin/orders/fee_table', order: order, kind: :partner
        end
      end

    end
  end

  form do |f|
    f.semantic_errors
    # NOTE(okubo): form切り替えボタン, 編集時のみ表示
    if f.object&.id.present?
      render 'admin/orders/menu', order: order
    end

    f.inputs do
      f.input :status,
              as: :select,
              collection: Order.status.values.map { |i| [i.text, i] },
              input_html: { disabled: true }

      f.input :user,
              as: :select,
              collection: User.includes(:company).customers.map { |i| [i.company&.facility_name, i.id] },
              input_html: { class: 'select2', disabled: f.object.id.present? }
      f.input :recreation, input_html: { class: 'select2', disabled: f.object.id.present? }

      # NOTE(okubo): createは依頼だけなので必要な項目だけ表示
      div class: 'official_input' do
        f.input :start_at,
                as: :date_time_picker,
                input_html: { disabled: f.object.start_at.present? },
                hint: '5分単位の時間はformに直接入力してください'
        f.input :zip, input_html: { disabled: f.object.start_at.present? }
        f.input :prefecture, input_html: { disabled: f.object.start_at.present? }
        f.input :city, input_html: { disabled: f.object.start_at.present? }
        f.input :street, input_html: { disabled: f.object.start_at.present? }
        f.input :building, input_html: { disabled: f.object.start_at.present? }
        f.input :number_of_people, input_html: { disabled: f.object.start_at.present? }
        f.input :number_of_facilities, input_html: { disabled: f.object.start_at.present? }
      end

      div class: 'cost_input' do
        if f.object.id.present?
          f.input :regular_price, input_html: { disabled: f.object.start_at.present? }
          f.input :instructor_amount, input_html: { disabled: f.object.start_at.present? }
          f.input :regular_material_price, input_html: { disabled: f.object.start_at.present? }
          f.input :instructor_material_amount, input_html: { disabled: f.object.start_at.present? }
          f.input :additional_facility_fee, input_html: { disabled: f.object.start_at.present? }
          f.input :transportation_expenses, input_html: { disabled: f.object.start_at.present? }
          f.input :expenses, input_html: { disabled: f.object.start_at.present? }
          f.input :zoom_price, input_html: { disabled: f.object.start_at.present? }
          f.input :support_price, input_html: { disabled: f.object.start_at.present? }
        end
      end

      div class: 'evaluation_input' do
        report_accepted = f.object.report&.status&.accepted?
        if f.object.status.value >= 70
          f.inputs I18n.t('activerecord.models.report'), for: [:report, f.object.report] do |ff|
            ff.input :status, as: :select, collection: Report.status.values.map { |val| [val.text, val] }, input_html: { disabled: report_accepted }
          end

          f.inputs I18n.t('activerecord.models.evaluation'), for: [:evaluation, f.object.report&.evaluation] do |ff|
            ff.input :ingenuity, as: :select, collection: Evaluation.ingenuity.values.map { |val| [val.text, val] }, input_html: { disabled: report_accepted }
            ff.input :communication, as: :select, collection: Evaluation.communication.values.map { |val| [val.text, val] }, input_html: { disabled: report_accepted }
            ff.input :smoothness, as: :select, collection: Evaluation.smoothness.values.map { |val| [val.text, val] }, input_html: { disabled: report_accepted }
            ff.input :price, as: :select, collection: Evaluation.price.values.map { |val| [val.text, val] }, input_html: { disabled: report_accepted }
            ff.input :want_to_order_agein, as: :select, collection: Evaluation.want_to_order_agein.values.map { |val| [val.text, val] }, input_html: { disabled: report_accepted }
            ff.input :message, input_html: { disabled: report_accepted }
            ff.input :other_message, input_html: { disabled: report_accepted }
          end
        end
      end

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

      # NOTE(okubo): recの金額を元に自動的に金額が反映されるようにする
      recreation = Recreation.find(params[:order][:recreation_id])
      order = recreation.orders.build(
        user_id: params[:order][:user_id],
        regular_price: recreation.regular_price,
        instructor_amount: recreation.instructor_amount,
        regular_material_price: recreation.regular_material_price,
        instructor_material_amount: recreation.instructor_material_amount,
        additional_facility_fee: recreation.additional_facility_fee,
      )
      order.chats.build(user_id: current_user.id, message: message)
      order.save!

      CustomerChatStartMailer.notify(order, order.user).deliver_now
      PartnerChatStartMailer.notify(order, order.user).deliver_now
      redirect_to admin_order_path(order.id)
    rescue StandardError => e
      Rails.logger.error e
      super
    end

    def update
      order = Order.find(params[:id].to_i)

      if order.status.value >= 70 && permitted_params[:order][:evaluation].present?
        # TODO(okubo): 評価更新する
        evaluation_params = permitted_params[:order][:evaluation]
        attrs = {
          ingenuity: evaluation_params[:ingenuity],
          communication: evaluation_params[:communication],
          smoothness: evaluation_params[:smoothness],
          price: evaluation_params[:price],
          want_to_order_agein: evaluation_params[:want_to_order_agein],
          message: evaluation_params[:message],
          other_message: evaluation_params[:other_message]
        }

        # NOTE(okubo): 評価はあれば更新で、なければ作成
        order.report&.evaluation.present? ? order.report.evaluation.update(attrs) : order.report.create_evaluation(attrs)
        # NOTE(okubo): レポートの更新。order.statusにも影響あるので、重要
        order.report.update!(status: permitted_params[:order][:report][:status])
        order.update!(status: order.status)

        # NOTE(okubo): reportのstatusによってメール切り替え
        ReportDenyMailer.notify(order).deliver_now if order.report.status.denied?
        PartnerCompleteReportMailer.notify(order).deliver_now if order.report.status.accepted?
        return redirect_to admin_order_path(order.id)
      end

      order.update!(permitted_params[:order])

      # NOTE(okubo): 正式依頼のメール発火
      if order.status == :facility_request_in_progress && permitted_params[:order][:start_at].present?
        # NOTE(okubo): このメールは正式依頼のみなので、移動はしないで
        OrderRequestMailer.notify(order, order.user).deliver_now
      end
      redirect_to admin_order_path(order.id)
    rescue StandardError => e
      super
    end
  end
end
