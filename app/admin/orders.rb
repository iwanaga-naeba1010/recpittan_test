# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength, Metrics/AbcSize
ActiveAdmin.register Order do
  includes :user
  decorate_with OrderDecorator

  permit_params(
    %i[
      user_id recreation_id zip prefecture city street building number_of_people
      number_of_facilities status is_accepted start_at end_at
      price amount material_price material_amount
      additional_facility_fee transportation_expenses support_price expenses contract_number
      memo
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
    column 'ステータス更新日（できれば）', &:status_updated_at
    column :facility_request_approved_at
    column :approved_total_partner_payment
    column :final_report_approved_at
    column "CSVダウンロード日\nyyyy/mm/dd hh:mm", humanize_name: false do
      Time.current
    end

    # 施設
    column "施設ID\nレク開催施設ID", humanize_name: false, &:facility_id
    column "施設名\nレク開催施設", &:facility_name
    column "郵便番号\nレク開催施設", &:facility_zip
    column "都道府県\nレク開催施設", &:facility_prefecture
    column "市区町村\nレク開催施設", &:facility_city
    column "町名/番地\nレク開催施設", &:facility_street
    column "建物名\nレク開催施設", &:facility_building

    # パートナー情報
    column 'パートナーID', humanize_name: false, &:recreation_user_id
    column 'パートナー名', &:recreation_profile_name
    column 'レクID', &:recreation_id
    column 'レク', &:recreation_title

    # 案件情報
    column :start_at
    column :end_at
    column :number_of_people
    column :number_of_facilities

    # その他
    column :memo
    column :is_accepted
    column :contract_number
    column :is_managercontrol
    column :order_create_source_code
    column :manage_company_code

    column :amount
    column :tax_rate
    column :tax_amount
    column :amount_with_tax

    # 正式依頼
    column :material_amount
    column :total_material_amount
    column :transportation_expenses
    column :expenses

    # パートナー終了報告
    column '追加施設費用 （設定値）', &:additional_facility_fee
    column :additional_facility_fee
    column :number_of_facilities
    column :total_additional_facility_fee
    column :total_partner_payment_with_tax

    # 確定支払
    column :partner_fee_rate
    column 'パートナー手数料計算金額', &:partner_fee_base_amount
    column 'パートナー手数料（税込）', &:partner_fee_with_tax
    column :additional_facility_fee_commission
    column :total_additional_facility_fee_commission
    column :non_invoice_partner_fee_rate
    column :non_invoice_partner_fee
    column 'zoomレンタル料（設定値）', &:zoom_rental_fee
    column :recreation_kind
    column :is_zoom_rental
    column :zoom_rental_actual_fee
    column :partner_service_fee
    column :partner_deduction_subtotal

    # 確定請求
    column :facility_fee_rate
    column :facility_fee_base_amount
    column :facility_fee
    column :facility_service_fee
    column :support_price
    column :facility_fee_subtotal

    # 確定支払
    column :withholding_tax_rate
    column :withholding_tax_amount
    column :partner_payment_amount

    # 確定請求
    column :gross_profit_incl_tax
    column :gross_profit_margin
    column :facility_billing_amount
  end

  index do
    id_column
    column(:user) { |order| link_to order.user.company.facility_name, admin_company_path(order.user.company.id) }
    column :recreation
    column :start_at
    column :contract_number
    column(:status, &:status_text)
    column(:memo)
    column(:coupon_code)

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
          row :coupon_code
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
        render 'admin/orders/memo', order:
      end

      tab 'チャット' do
        panel 'チャット', style: 'margin-top: 30px;' do
          render 'admin/orders/chat', order:
        end
      end

      tab '終了報告' do
        panel '終了報告', style: 'margin-top: 30px;' do
          render 'admin/orders/report', report: order&.report
        end
      end

      tab '請求情報' do
        panel '施設請求額', style: 'margin-top: 30px;' do
          render 'admin/orders/fee_table', order:, kind: :customer
        end

        panel 'パートナー支払額', style: 'margin-top: 30px;' do
          render 'admin/orders/fee_table', order:, kind: :partner
        end
      end
    end
  end

  form do |f|
    f.semantic_errors
    # NOTE(okubo): form切り替えボタン, 編集時のみ表示
    if f.object&.id.present?
      render 'admin/orders/menu', order:
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
      f.input :memo

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
          f.input :price
          f.input :amount
          f.input :material_price
          f.input :material_amount
          f.input :additional_facility_fee
          f.input :transportation_expenses, as: :number
          f.input :expenses, as: :number
          f.input :support_price
          f.input :coupon_code

          # NOTE(okubo): オンラインレクの場合zoom情報を格納
          if f.object.recreation.kind.online?
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
        price: recreation.price,
        amount: recreation.amount,
        material_price: recreation.material_price,
        material_amount: recreation.material_amount,
        additional_facility_fee: recreation.additional_facility_fee
      )

      current_time = Time.zone.now
      year = current_time.month == 12 ? current_time.year + 1 : current_time.year
      month = current_time.month == 12 ? 1 : current_time.month + 1
      # NOTE(okubo): order_datesを作成しないと正式依頼で日付が表示されない
      order.order_dates.build(
        year:,
        month:,
        date: current_time.day,
        start_hour: '10',
        start_minute: '00',
        end_hour: '12',
        end_minute: '00'
      )

      order.save!

      CustomerChatStartMailer.notify(order:).deliver_now
      PartnerChatStartMailer.notify(order:).deliver_now
      SlackNotifier.new(channel: '#アクティブチャットスレッド').send('管理画面から案件追加を行いました', "管理画面案件URL：#{admin_order_url(order.id)}")

      redirect_to admin_order_path(order.id)
    rescue StandardError => e
      Sentry.capture_exception(e)
      Rails.logger.error e
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
      if order&.report.present? &&
         (order.status.value >= 70 && order.status.value <= 80) &&
         permitted_params[:order][:evaluation].present?
        order.report.update(permitted_params[:order][:report_attributes])
        order.report.create_evaluation(permitted_params[:order][:evaluation])

        order.update!(permitted_params[:order].except(:evaluation, :report_attributes))

        # NOTE(okubo): statusに応じてメール変更
        ReportDenyMailer.notify(order).deliver_now if order.report_status.denied?
        ReportAcceptMailer.notify(order:).deliver_now if order.report_status.accepted?
      end

      # NOTE(okubo): 相談中
      if order.status.value >= 10 && order.status.value <= 40
        # NOTE(okubo): paramsにstart_atが存在する && order.start_atが空 === 正式依頼ならメール
        is_send_mail = permitted_params[:order][:start_at].present? && order.start_at.nil?

        order.update!(permitted_params[:order].except(:evaluation, :report_attributes))

        # NOTE(okubo): 時間の記載がある -> 正式依頼
        # TODO(okubo): order.start_at.nil? つまり、あだ入力できていない、なら送信
        OrderRequestMailer.notify(order:).deliver_now if is_send_mail
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
      super
    end
  end
end
# rubocop:enable Metrics/BlockLength, Metrics/AbcSize
