# frozen_string_literal: true

require 'csv'

module Exports
  class PartnerPaymentStatementCsvService
    def initialize(partners, orders)
      @partners = partners
      @orders = orders.group_by { |order| order.recreation.user_id }
    end

    def call
      generate_csv
    end

    private

    def generate_csv
      CSV.generate(headers: true) do |csv|
        csv << csv_headers

        @partners.each do |partner|
          orders = @orders[partner.id]
          csv << csv_row(partner, orders)
        end
      end
    end

    def csv_headers
      [
        'パートナーID',
        'パートナー名または法人名',
        '法人フラグ',
        'パートナーインボイス登録番号（あれば）',
        'パートナーの個人番号又は法人番号',
        'パートナー住所',
        '国外在住フラグ',
        'レク実施の年月',
        '報酬の支払日（支払年月）',
        '講師謝礼全体（税込）',
        '消費税（切り捨て）',
        '源泉徴収税額',
        'システム使用料',
        'システム使用料にかかる消費税',
        'インボイス非登録手数料',
        '差引支払額（対象月の合計）',
        '区分（固定）',
        '細目（固定・全額）',
      ]
    end

    def csv_row(partner, orders)
      beginning_of_prev_month = Time.current.prev_month.beginning_of_month.strftime('%Y/%m/%d')
      end_of_prev_month = Time.current.prev_month.end_of_month.strftime('%Y/%m/%d')

      [
        partner.id,
        partner.username,
        partner.bank_account&.is_corporate ? 'ON' : '空白',
        partner.bank_account&.invoice_number,
        bank_number(partner.bank_account),
        partner_address(partner.partner_info),
        partner.bank_account&.is_foreignresident ? 'ON' : '空白',
        beginning_of_prev_month,
        end_of_prev_month,
        calculate_total(orders, :total_partner_payment_with_tax),
        calculate_total(orders, :total_partner_payment_with_tax) / 11,
        calculate_total(orders, :withholding_tax_amount),
        calculate_total(orders, :partner_deduction_subtotal),
        calculate_total(orders, :partner_deduction_subtotal) / 11,
        calculate_total(orders, :non_invoice_partner_fee),
        calculate_total(orders, :partner_payment_amount),
        '講師料', # Fixed text
        'レクリエーション業務委託' # Fixed text
      ]
    end

    def partner_address(partner_info)
      return '' if partner_info.blank?

      [
        partner_info.postal_code,
        partner_info.prefecture,
        partner_info.city,
        partner_info.address1,
        partner_info.address2
      ].compact_blank.join(' ')
    end

    def bank_number(bank_account)
      return '' if bank_account.blank?

      bank_account.my_number || bank_account.corporate_number
    end

    def calculate_total(order_list, attribute_name)
      order_list.sum { |order| order.send(attribute_name).to_i }
    end
  end
end
