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
# Indexes
#
#  index_orders_on_recreation_id  (recreation_id)
#  index_orders_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (recreation_id => recreations.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :order do
    user
    recreation
    price { 20000 }
    amount { 10000 }
    material_price { 1000 }
    material_amount { 500 }
    number_of_people { 1 }
    message { 'MyText' }
    status { 10 }
    transportation_expenses { 0 }
    expenses { 0 }
    is_accepted { false }
    additional_facility_fee { 1500 }
    number_of_facilities { 1 }
    is_managercontrol { false }
    business_integration_flag { true }
    is_withholding_tax { false }
    partner_invoice_registration_flag { false }
    is_zoom_rental { false }
    total_partner_payment_with_tax { 10000 }
    withholding_tax_amount { 20000 }
    partner_deduction_subtotal { 60000 }
    non_invoice_partner_fee { 20000 }
    partner_payment_amount { 80000 }
  end

  trait :with_report do
    after(:create) do |order|
      create(:report, order_id: order.id)
    end
  end

  trait :with_order_dates do
    after(:create) do |order|
      create(:order_date, order_id: order.id)
    end
  end

  trait :with_unreported_completed do
    after(:create) do |order|
      order.update(
        start_at: DateTime.yesterday,
        is_accepted: true
      )
    end
  end

  trait :with_final_report_admits_not do
    after(:create) do |order|
      create(:report, order_id: order.id)
      order.update(
        start_at: 3.days.ago,
        is_accepted: true
      )
    end
  end

  trait :with_finished do
    after(:create) do |order|
      report = create(:report, order_id: order.id, status: :accepted)
      create(:evaluation, report_id: report.id)

      order.update(
        start_at: 3.days.ago,
        is_accepted: true
      )
    end
  end
end
