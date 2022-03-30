# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
ActiveAdmin.register Order do
  includes :user

  permit_params(
    %i[
      user_id recreation_id zip prefecture city street building number_of_people
      number_of_facilities status is_accepted start_at end_at
      regular_price instructor_amount regular_material_price instructor_material_amount
      additional_facility_fee transportation_expenses support_price expenses contract_number
    ],
    zoom_attributes: %i[id url price created_by],
    report_attributes: %i[
      id body expenses expenses number_of_facilities number_of_people status transportation_expenses
    ],
    evaluation: %i[
      id communication ingenuity message other_message price smoothness want_to_order_agein
    ]
    # TODO(okubo): evaluationもattributesで管理したいけど、reportにうまくnestできなかったので
    # ひとまずevaluationで実装。時間できたら、attributesにしたい
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
    column('zoom利用料', &:zoom_cost)
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
          row('zoom利用料', &:zoom_cost)
          row('zoomURL') do |order|
            simple_format order&.zoom_url
          end
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
              hint: '完了以降は変更可能ですが、それ以外は強制執行モードで対応しています'

      f.input :user,
              as: :select,
              collection: User.includes(:company).customers.map { |i| [i.company&.facility_name, i.id] },
              input_html: { class: 'select2' }
      f.input :recreation, input_html: { class: 'select2' }

      # NOTE(okubo): createは依頼だけなので必要な項目だけ表示
      div class: 'official_input' do
        f.input :start_at,
                as: :date_time_picker,
                hint: '5分単位の時間はformに直接入力してください'

        f.input :end_at,
                as: :date_time_picker,
                hint: '5分単位の時間はformに直接入力してください'
        f.input :zip
        f.input :prefecture
        f.input :city
        f.input :street
        f.input :building
        f.input :number_of_people, as: :number
        f.input :number_of_facilities
      end

      div class: 'cost_input' do
        if f.object.id.present?
          f.input :regular_price
          f.input :instructor_amount
          f.input :regular_material_price
          f.input :instructor_material_amount
          f.input :additional_facility_fee
          f.input :transportation_expenses, as: :number
          f.input :expenses, as: :number
          f.input :support_price

          # NOTE(okubo): オンラインレクの場合zoom情報を格納
          if f.object.recreation.is_online?
            f.inputs I18n.t('activerecord.models.zoom'), for: [:zoom, f.object.zoom || f.object.build_zoom] do |ff|
              ff.input :price
              ff.input :created_by, as: :select, collection: Zoom.created_by.values.map { |val| [val.text, val] }
              ff.input :url, as: :text
            end
          end
        end
      end

      div class: 'evaluation_input' do
        if f.object.status.value >= 70
          f.inputs I18n.t('activerecord.models.report'), for: [:report, f.object.report] do |ff|
            ff.input :body
            ff.input :status, as: :select, collection: Report.status.values.map { |val| [val.text, val] }
          end

          f.inputs I18n.t('activerecord.models.evaluation'), for: [:evaluation, f.object&.report&.evaluation || Evaluation.new] do |ff|
            ff.input :ingenuity, as: :select, collection: Evaluation.ingenuity.values.map { |val| [val.text, val] }
            ff.input :communication, as: :select, collection: Evaluation.communication.values.map { |val| [val.text, val] }
            ff.input :smoothness, as: :select, collection: Evaluation.smoothness.values.map { |val| [val.text, val] }
            ff.input :price, as: :select, collection: Evaluation.price.values.map { |val| [val.text, val] }
            ff.input :want_to_order_agein, as: :select, collection: Evaluation.want_to_order_agein.values.map { |val| [val.text, val] }
            ff.input :message
            ff.input :other_message
          end
        end
      end

      f.input :contract_number, hint: 'スプレッドシート管理のIDを紐づけるための項目です。将来的にシステムに移行しますが、現在は入力のみとなっております。'
    end

    f.actions
  end

  controller do
    def show
      @order = Order.order_asc.find(params[:id])
    end

    def create
      # NOTE(okubo): recの金額を元に自動的に金額が反映されるようにする
      recreation = Recreation.find(params[:order][:recreation_id])
      order = recreation.orders.build(
        user_id: params[:order][:user_id],
        regular_price: recreation.regular_price,
        instructor_amount: recreation.instructor_amount,
        regular_material_price: recreation.regular_material_price,
        instructor_material_amount: recreation.instructor_material_amount,
        additional_facility_fee: recreation.additional_facility_fee
      )

      current_time = Time.zone.now
      # NOTE(okubo): order_datesを作成しないと正式依頼で日付が表示されない
      order.order_dates.build(
        year: current_time.year,
        month: current_time.month + 1,
        date: current_time.day,
        start_hour: '10',
        start_minute: '00',
        end_hour: '12',
        end_minute: '00'
      )

      order.save!

      CustomerChatStartMailer.notify(order, order.user).deliver_now
      PartnerChatStartMailer.notify(order, order.user).deliver_now
      SlackNotifier.new(channel: '#アクティブチャットスレッド').send('管理画面から案件追加を行いました', "管理画面案件URL：#{admin_order_url(order.id)}")

      redirect_to admin_order_path(order.id)
    rescue StandardError => e
      Rails.logger.error e
      Sentry.capture_exception(e)
      super
    end

    def update
      order = Order.find(params[:id].to_i)
      # NOTE(okubo): 完了系のstatus. 全てupdateしている
      if order.status.value >= 200
        order.report.update(permitted_params[:order][:report_attributes])
        order.report.evaluation.update(permitted_params[:order][:evaluation])
        order.update!(permitted_params[:order].except(:evaluation, :report_attributes))
      end

      # NOTE(okubo): 終了報告系
      if order&.report&.present? &&
         (order.status.value >= 70 && order.status.value <= 80) &&
         permitted_params[:order][:evaluation].present?
        order.report.update(permitted_params[:order][:report_attributes])
        order.report.create_evaluation(permitted_params[:order][:evaluation])

        order.update!(permitted_params[:order].except(:evaluation, :report_attributes))

        # NOTE(okubo): statusに応じてメール変更
        ReportDenyMailer.notify(order).deliver_now if order.report_status.denied?
        ReportAcceptMailer.notify(order).deliver_now if order.report_status.accepted?
      end

      # NOTE(okubo): 相談中
      if order.status.value >= 10 && order.status.value <= 40
        order.update!(permitted_params[:order].except(:evaluation, :report_attributes))
        # NOTE(okubo): 時間の記載がある -> 正式依頼
        # TODO(okubo): order.start_at.nil? つまり、あだ入力できていない、なら送信
        OrderRequestMailer.notify(order, order.user).deliver_now if permitted_params[:order][:start_at].present? && order.start_at.nil?
      end

      # NOTE(okubo): 開催前
      if order.status.value == 60
        order.update!(permitted_params[:order].except(:evaluation, :report_attributes))
      end

      SlackNotifier
        .new(channel: '#アクティブチャットスレッド')
        .send('管理画面から案件の更新を行いました', "管理画面案件URL：#{admin_order_url(order.id)}")
      redirect_to admin_order_path(order.id)
    rescue StandardError => e
      Rails.logger.error e
      Sentry.capture_exception(e)
      super
    end
  end
end
# rubocop:enable Metrics/BlockLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
