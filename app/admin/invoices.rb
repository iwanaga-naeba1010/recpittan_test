# frozen_string_literal: true

require 'csv'

# rubocop:disable Metrics/BlockLength, Metrics/AbcSize, Metrics/MethodLength
ActiveAdmin.register_page 'Invoices' do
  menu priority: 1, label: proc { '請求書CSV生成' }

  content title: proc { '請求書CSV生成' } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        span I18n.t('active_admin.dashboard_welcome.welcome')
        small I18n.t('active_admin.dashboard_welcome.call_to_action')
      end
    end

    columns do
      column do
        panel 'Info' do
          button_to 'CSVの生成実行', admin_invoices_path, { data: { confirm: 'CSV生成を行うと完了statusから請求書発行済みに変更となりますがよろしいですか？' } }
        end
      end
    end
  end

  controller do
    def create
      current_time = Time.zone.now
      # TODO(okubo): ここで案件を切り替えたりする
      invoices = []

      User.customers.all.includes(:company, :orders).each do |customer|
        orders = customer.orders.to_a.map { |order| order if order.status.finished? }.compact
        next if orders.blank?

        invoice = {
          invoice_at: current_time.strftime('%Y/%m/%d'),
          title: "#{current_time.month}月分レクリエーション費用",
          code: '',
          facility_name: customer.company.facility_name,
          tax: 10,
          payment_due_date: "#{current_time.year}/#{(current_time + 1.month).month}/25",
          items: [],
          memo: '恐れ入りますが、振込手数料はご負担いただきますようお願い申し上げます。'
        }

        orders.each do |order|
          items = []
          items << {
            name: order.created_at.strftime('%m/%d'),
            price: order.regular_price,
            amount: 1,
            unit: '回'
          }

          if order.regular_material_price?
            items << {
              name: '材料費',
              price: order.total_material_price_for_customer,
              amount: order.number_of_people,
              unit: '個'
            }
          end

          if order.number_of_facilities?
            items << {
              name: '追加施設',
              price: order.total_facility_price_for_customer,
              amount: order.number_of_people,
              unit: '件'
            }
          end

          if order.support_price?
            items << {
              name: '調整費',
              price: order.support_price,
              amount: 1,
              unit: '回'
            }
          end

          if order.expenses?
            items << {
              name: '諸経費',
              price: order.expenses,
              amount: 1,
              unit: '件'
            }
          end

          if order.transportation_expenses?
            items << {
              name: '交通費',
              price: order.transportation_expenses,
              amount: 1,
              unit: '件'
            }
          end

          invoice[:items] = items
        end

        invoices << invoice
      end

      # NOTE(okubo): csv用のarrayに変換。あえて分けているのは責務の分割のため
      invoices_for_csv = invoices.map do |invoice|
        [
          invoice[:invoice_at],
          '',
          invoice[:title],
          invoice[:code],
          invoice[:facility_name],
          invoice[:tax],
          invoice[:payment_due_date],
          invoice[:items].map { |item| [item[:name], item[:amount], item[:unit], item[:price]] }.compact.flatten
        ].flatten
      end

      # NOTE(okubo): まとめて書くためにflattenで処理
      headers = [
        %w[請求日 請求番号 件名 取引先管理コード 施設名 消費税設定 お支払い期限],
        (1..20).map { |i| ["品目#{i}", "単位#{i}", "単価#{i}", "消費税率#{i}", "非課税フラグ#{i}"] }.flatten
      ].flatten

      csv_data = CSV.generate do |csv|
        csv << headers
        invoices_for_csv.each do |invoice|
          csv << invoice
        end
      end

      send_data csv_data, filename: '請求データ'
    end
  end
end
# rubocop:enable Metrics/BlockLength, Metrics/AbcSize, Metrics/MethodLength
