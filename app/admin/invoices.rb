# frozen_string_literal: true

require 'csv'

# rubocop:disable Metrics/BlockLength, Metrics/AbcSize, Metrics/MethodLength, Style/Next, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
ActiveAdmin.register_page 'Invoices' do
  menu priority: 1, label: proc { '請求書CSV生成' }

  content title: proc { '請求書CSV生成' } do
    columns do
      column do
        panel 'CSV生成' do
          button_to 'CSVの生成実行', admin_invoices_path
        end
      end
    end
  end

  controller do
    def create
      current_time = Time.zone.now
      invoices = []

      User.customers.includes(:company, :orders).find_each do |customer|
        orders = customer.orders.to_a.select { |order| order.status.finished? }
        next if orders.blank?

        invoice_information = customer.invoice_information

        invoice = {
          invoice_at: current_time.strftime('%Y/%m/%d'),
          title: "#{current_time.month}月分レクリエーション費用",
          code: invoice_information.present? ? invoice_information.code : '',
          facility_name: customer.company.facility_name,
          partner_name: '',
          tax: '',
          payment_due_date: "#{current_time.year}/#{(current_time + 1.month).month}/25",
          items: [],
          memo: '恐れ入りますが、振込手数料はご負担いただきますようお願い申し上げます。'
        }

        orders.each do |order|
          invoice[:partner_name] = order.recreation.user_username

          invoice[:items] << {
            name: "#{order.start_at.strftime('%m/%d')}#{order.recreation_title}",
            price: order.price,
            amount: 1,
            unit: '回'
          }

          if order.number_of_people? && order.material_price.present? && order.material_price != 0
            invoice[:items] << {
              name: '材料費',
              price: order.material_price,
              amount: order.number_of_people,
              unit: '個'
            }
          end

          if order.number_of_facilities? && order.additional_facility_fee.present? && order.additional_facility_fee != 0
            invoice[:items] << {
              name: '追加施設',
              price: order.additional_facility_fee,
              amount: order.number_of_facilities,
              unit: '件'
            }
          end

          if order.support_price?
            invoice[:items] << {
              name: '調整費',
              price: order.support_price,
              amount: 1,
              unit: '回'
            }
          end

          if order.expenses?
            invoice[:items] << {
              name: '諸経費',
              price: order.expenses,
              amount: 1,
              unit: '件'
            }
          end

          if order.transportation_expenses?
            invoice[:items] << {
              name: '交通費',
              price: order.transportation_expenses,
              amount: 1,
              unit: '件'
            }
          end
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
          invoice[:partner_name],
          invoice[:tax],
          invoice[:payment_due_date],
          invoice[:items].map do |item|
            [item[:name], item[:amount], item[:unit], item[:price], 10, ''].compact.flatten
          end
        ].flatten
      end

      # NOTE(okubo): まとめて書くためにflattenで処理
      headers = [
        %w[請求日 請求番号 件名 取引先管理コード 施設名 パートナー名 消費税設定 お支払い期限],
        (1..40).map { |i| ["品目#{i}", "数量#{i}", "単位#{i}", "単価#{i}", "消費税率#{i}", "非課税フラグ#{i}"] }.flatten
      ].flatten

      csv_data = CSV.generate do |csv|
        csv << headers
        invoices_for_csv.each do |invoice|
          csv << invoice
        end
      end

      send_data csv_data, filename: '請求データ.csv'
    end
  end
end
# rubocop:enable Metrics/BlockLength, Metrics/AbcSize, Metrics/MethodLength, Style/Next, Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
