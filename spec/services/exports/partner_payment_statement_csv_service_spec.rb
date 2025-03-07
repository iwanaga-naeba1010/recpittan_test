# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exports::PartnerPaymentStatementCsvService, type: :service do
  describe '#call' do
    let!(:partner_list) { create_list(:user, 2, :partner_with_orders) }
    let!(:order_list) { Order.with_payments_in_previous_month }
    let!(:csv_headers) {
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
        '細目（固定・全額）'
      ]
    }

    subject do
      described_class.new(partner_list, order_list).call
    end

    it 'returns a CSV file' do
      expect(subject).to be_a(String)
    end

    it 'returns a CSV file with headers' do
      csv_lines = CSV.parse(subject, headers: true)

      expect(csv_lines.headers).to eq(csv_headers)
    end

    it 'returns a CSV file with data' do
      orders = group_oders_by_partner(order_list)
      csv_lines = CSV.parse(subject, headers: true)

      csv_lines.each do |line|
        partner_id = line['パートナーID'].to_i
        partner = partner_list.detect { |p| p.id == partner_id }

        expect(line['パートナー名または法人名']).to eq(partner.username)
        expect(line['法人フラグ']).to eq(partner.bank_account.is_corporate ? 'ON' : '空白')
        expect(line['パートナーインボイス登録番号（あれば）']).to eq(partner.bank_account.invoice_number)
        expect(line['パートナーの個人番号又は法人番号']).to eq(bank_number(partner.bank_account))
        expect(line['パートナー住所']).to eq(partner_address(partner.partner_info))
        expect(line['国外在住フラグ']).to eq(partner.bank_account&.is_foreignresident ? 'ON' : '空白')
        expect(line['レク実施の年月']).to eq(Time.current.prev_month.beginning_of_month.strftime('%Y/%m/%d'))
        expect(line['報酬の支払日（支払年月）']).to eq(Time.current.prev_month.end_of_month.strftime('%Y/%m/%d'))
        expect(line['講師謝礼全体（税込）']).to eq(calculate_total(orders[partner_id], :total_partner_payment_with_tax).to_s)
        expect(line['消費税（切り捨て）']).to eq((calculate_total(orders[partner_id], :total_partner_payment_with_tax) / 11).to_s)
        expect(line['源泉徴収税額']).to eq(calculate_total(orders[partner_id], :withholding_tax_amount).to_s)
        expect(line['システム使用料']).to eq(calculate_total(orders[partner_id], :partner_deduction_subtotal).to_s)
        expect(line['システム使用料にかかる消費税']).to eq((calculate_total(orders[partner_id], :partner_deduction_subtotal) / 11).to_s)
        expect(line['インボイス非登録手数料']).to eq(calculate_total(orders[partner_id], :non_invoice_partner_fee).to_s)
        expect(line['差引支払額（対象月の合計）']).to eq(calculate_total(orders[partner_id], :partner_payment_amount).to_s)
        expect(line['区分（固定）']).to eq('講師料')
        expect(line['細目（固定・全額）']).to eq('レクリエーション業務委託')
      end
    end
  end

  private

  def calculate_total(orders, attribute_name)
    orders.sum { |order| order.send(attribute_name).to_i }
  end

  def group_oders_by_partner(orders)
    orders.group_by { |order| order.recreation.user_id }
  end

  def bank_number(bank_account)
    return '' if bank_account.blank?

    bank_account.my_number || bank_account.corporate_number
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
end
