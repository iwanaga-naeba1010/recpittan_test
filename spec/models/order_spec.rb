# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                                                                         :bigint           not null, primary key
#  additional_facility_fee                                                    :integer          default(0)
#  additional_facility_fee_commission(追加施設手数料)                         :integer
#  amount                                                                     :integer          default(0)
#  amount_with_tax(パートナー謝礼（税込）)                                    :integer
#  approved_total_partner_payment(正式依頼承認時のパートナー謝礼全体（税込）) :integer
#  building                                                                   :string
#  business_integration_flag(業務統合フラグ)                                  :boolean          default(TRUE), not null
#  city                                                                       :string
#  contract_number                                                            :string
#  coupon_code                                                                :string
#  end_at                                                                     :datetime
#  expenses                                                                   :integer          default(0)
#  facility_billing_amount(施設請求額)                                        :integer
#  facility_fee(施設手数料（税込）)                                           :integer
#  facility_fee_base_amount(施設手数料計算金額)                               :integer
#  facility_fee_rate(施設手数料率)                                            :decimal(15, 3)
#  facility_fee_subtotal(施設手数料小計)                                      :integer
#  facility_request_approved_at(正式依頼承認日（ダウンロード日）)             :datetime
#  facility_service_fee(施設サービス利用料)                                   :integer
#  final_check_status                                                         :integer
#  final_report_approved_at(施設の終了報告の承認日)                           :datetime
#  gross_profit_incl_tax(粗利（税込）)                                        :integer
#  gross_profit_margin(粗利率)                                                :decimal(15, 3)
#  is_accepted                                                                :boolean          default(FALSE)
#  is_managercontrol(運営管理フラグ)                                          :boolean          default(FALSE), not null
#  is_open                                                                    :boolean          default(TRUE), not null
#  is_withholding_tax(源泉徴収フラグ)                                         :boolean          default(FALSE), not null
#  is_zoom_rental(zoomレンタルフラグ)                                         :boolean          default(FALSE), not null
#  manage_company_code(案件管理会社区分)                                      :string
#  material_amount                                                            :integer          default(0)
#  material_price                                                             :integer          default(0)
#  memo                                                                       :string
#  non_invoice_partner_fee(インボイス非登録パートナー手数料)                  :integer
#  non_invoice_partner_fee_rate(インボイス非登録パートナー手数率)             :decimal(15, 3)
#  number_of_facilities                                                       :integer
#  number_of_people                                                           :integer
#  order_create_source_code(案件作成元区分)                                   :string
#  partner_deduction_subtotal(パートナー控除小計)                             :integer
#  partner_fee_rate(パートナー手数料率)                                       :decimal(15, 3)
#  partner_invoice_registration_flag(パートナーインボイス登録フラグ)          :boolean          default(FALSE), not null
#  partner_payment_amount(パートナー支払額)                                   :integer
#  partner_service_fee(パートナーサービス利用料)                              :integer
#  prefecture                                                                 :string
#  price                                                                      :integer          default(0)
#  recreation_kind(レクマスタ、レク種類)                                      :integer
#  specific_facility_plan_management_code(特定施設プラン管理コード)           :string
#  start_at                                                                   :datetime
#  status                                                                     :integer
#  status_updated_at(ステータス更新日)                                        :datetime
#  street                                                                     :string
#  support_price                                                              :integer          default(0)
#  tax_amount(消費税)                                                         :integer
#  tax_rate(消費税率)                                                         :decimal(15, 3)
#  total_additional_facility_fee(追加施設費合計)                              :integer
#  total_additional_facility_fee_commission(追加施設手数料計)                 :integer
#  total_material_amount(材料費合計)                                          :integer
#  total_partner_payment_with_tax(パートナー謝礼全体（税込）)                 :integer
#  transportation_expenses                                                    :integer          default(0)
#  withholding_tax_amount(源泉徴収税額)                                       :integer
#  withholding_tax_rate(源泉徴収税率)                                         :decimal(15, 3)
#  zip                                                                        :string
#  zoom_rental_actual_fee(zoomレンタル使用料金)                               :integer
#  zoom_rental_fee(zoomレンタル料)                                            :integer
#  created_at                                                                 :datetime         not null
#  updated_at                                                                 :datetime         not null
#  recreation_id                                                              :bigint           not null
#  user_id                                                                    :bigint           not null
#
# Foreign Keys
#
#  orders_recreation_id_fkey  (recreation_id => recreations.id)
#  orders_user_id_fkey        (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_customer }
  let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }
  describe 'before_save::switch_status_befire_save' do
    context 'with valid parameters' do
      it 'changes nothing when status is finished' do
        order.update(status: :finished)
        expect(order.status).to eq :finished
      end

      it 'changes nothing when status is invoice_issued' do
        order.update(status: :invoice_issued)
        expect(order.status).to eq :invoice_issued
      end

      it 'changes nothing when status is paid' do
        order.update(status: :paid)
        expect(order.status).to eq :paid
      end

      it 'changes nothing when status is canceled' do
        order.update(status: :canceled)
        expect(order.status).to eq :canceled
      end

      it 'changes nothing when status is travled' do
        order.update(status: :travled)
        expect(order.status).to eq :travled
      end

      it 'changes to facility_request_in_progress when customer requested but partner was not accepted' do
        current_time = Time.current
        order.update(start_at: current_time.tomorrow, is_accepted: false)
        expect(order.status).to eq :facility_request_in_progress
      end

      it 'changes to waiting_for_an_event_to_take_place when customer requested and partner was accepted' do
        current_time = Time.current
        order.update(start_at: current_time.tomorrow, is_accepted: true)
        expect(order.status).to eq :waiting_for_an_event_to_take_place
      end

      it 'changes to unreported_completed after finished recreation but partner did not complete report yet' do
        current_time = Time.current
        order.update(start_at: current_time.ago(1.day), is_accepted: true)
        expect(order.status).to eq :unreported_completed
      end

      it 'changes to final_report_admits_not after finished recreation and partner completed report but customer did not accepted' do
        current_time = Time.current
        # NOTE: reportを事前に作成しないと発火しないので注意が必要
        order.create_report(attributes_for(:report))
        order.update(start_at: current_time.ago(1.day), is_accepted: true)
        expect(order.status).to eq :final_report_admits_not
      end

      it 'changes to finished after finished recreation and partner completed report and customer accepted' do
        current_time = Time.current
        # NOTE: reportを事前に作成しないと発火しないので注意が必要
        order.create_report(attributes_for(:report, status: :accepted))
        order.update(start_at: current_time.ago(1.day), is_accepted: true)
        expect(order.status).to eq :finished
      end
    end
  end

  describe 'scope :with_payments_in_previous_month' do
    let!(:order_beginning_of_prev_month) { create(:order, start_at: 1.month.ago.beginning_of_month + 2.days) }
    let!(:order_end_of_prev_month) { create(:order, start_at: 1.month.ago.end_of_month - 2.days) }
    let!(:order_this_month) { create(:order, start_at: Time.current.beginning_of_month) }
    let!(:order_two_months_ago) { create(:order, start_at: 2.months.ago) }

    it 'returns orders within the previous month' do
      result = Order.with_payments_in_previous_month

      expect(result).to include(order_beginning_of_prev_month, order_end_of_prev_month)
      expect(result).not_to include(order_this_month, order_two_months_ago)
    end
  end

  it { is_expected.to have_db_column(:is_managercontrol).of_type(:boolean).with_options(default: false, null: false) }
  it { is_expected.to have_db_column(:order_create_source_code).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:manage_company_code).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:business_integration_flag).of_type(:boolean).with_options(default: true, null: false) }
  it { is_expected.to have_db_column(:is_withholding_tax).of_type(:boolean).with_options(default: false, null: false) }
  it { is_expected.to have_db_column(:status_updated_at).of_type(:datetime).with_options(null: true) }
  it { is_expected.to have_db_column(:facility_request_approved_at).of_type(:datetime).with_options(null: true) }
  it { is_expected.to have_db_column(:approved_total_partner_payment).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:final_report_approved_at).of_type(:datetime).with_options(null: true) }
  it { is_expected.to have_db_column(:tax_rate).of_type(:decimal).with_options(precision: 15, scale: 3, null: true) }
  it { is_expected.to have_db_column(:tax_amount).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:amount_with_tax).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:total_material_amount).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:total_additional_facility_fee).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:total_partner_payment_with_tax).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:partner_fee_rate).of_type(:decimal).with_options(precision: 15, scale: 3, null: true) }
  it { is_expected.to have_db_column(:additional_facility_fee_commission).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:total_additional_facility_fee_commission).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:partner_invoice_registration_flag).of_type(:boolean).with_options(default: false, null: false) }
  it { is_expected.to have_db_column(:non_invoice_partner_fee_rate).of_type(:decimal).with_options(precision: 15, scale: 3, null: true) }
  it { is_expected.to have_db_column(:non_invoice_partner_fee).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:zoom_rental_fee).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:recreation_kind).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:is_zoom_rental).of_type(:boolean).with_options(default: false, null: false) }
  it { is_expected.to have_db_column(:zoom_rental_actual_fee).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:partner_service_fee).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:partner_deduction_subtotal).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:facility_fee_rate).of_type(:decimal).with_options(precision: 15, scale: 3, null: true) }
  it { is_expected.to have_db_column(:facility_fee_base_amount).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:facility_fee_base_amount).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:facility_fee).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:facility_service_fee).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:facility_fee_subtotal).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:withholding_tax_rate).of_type(:decimal).with_options(precision: 15, scale: 3, null: true) }
  it { is_expected.to have_db_column(:withholding_tax_amount).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:specific_facility_plan_management_code).of_type(:string).with_options(null: true) }
  it { is_expected.to have_db_column(:partner_payment_amount).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:gross_profit_incl_tax).of_type(:integer).with_options(null: true) }
  it { is_expected.to have_db_column(:gross_profit_margin).of_type(:decimal).with_options(precision: 15, scale: 3, null: true) }
  it { is_expected.to have_db_column(:facility_billing_amount).of_type(:integer).with_options(null: true) }
end
