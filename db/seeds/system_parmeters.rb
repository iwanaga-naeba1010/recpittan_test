# frozen_string_literal: true

puts 'create system_parmeters'

[
  {
    param_code: 'sales_tax_rate',
    param_name: '消費税率',
    value_int: 0.1,
    value_text: '',
    applied_date: Time.zone.parse('2000/01/01')
  },
  {
    param_code: 'additional_facility_cost',
    param_name: '追加施設費用 （設定値）',
    value_int: 2000,
    value_text: '',
    applied_date: Time.zone.parse('2000/01/01')
  },
  {
    param_code: 'partner_fee_rate',
    param_name: 'パートナー手数料率',
    value_int: 0.15,
    value_text: '',
    applied_date: Time.zone.parse('2000/01/01')
  },
  {
    param_code: 'partner_service_fee',
    param_name: 'パートナーサービス利用料',
    value_int: 0,
    value_text: '',
    applied_date: Time.zone.parse('2000/01/01')
  },
  {
    param_code: 'additional_facility_fee',
    param_name: '追加施設手数料',
    value_int: 1000,
    value_text: '',
    applied_date: Time.zone.parse('2000/01/01')
  },
  {
    param_code: 'invoice_non_registered_partner_fee_rate',
    param_name: 'インボイス非登録パートナー手数率',
    value_int: 0.02,
    value_text: '',
    applied_date: Time.zone.parse('2000/01/01')
  },
  {
    param_code: 'zoom_rental_fee',
    param_name: 'zoomレンタル料（設定値）',
    value_int: 300,
    value_text: '',
    applied_date: Time.zone.parse('2000/01/01')
  },
  {
    param_code: 'facility_fee_rate',
    param_name: '施設手数料率',
    value_int: 0.015,
    value_text: '',
    applied_date: Time.zone.parse('2000/01/01')
  },
  {
    param_code: 'facility_service_fee',
    param_name: '施設サービス利用料',
    value_int: 200,
    value_text: '',
    applied_date: Time.zone.parse('2000/01/01')
  },
  {
    param_code: 'withholding_tax_rate',
    param_name: '源泉徴収税率',
    value_int: 0.1021,
    value_text: '',
    applied_date: Time.zone.parse('2000/01/01')
  },
  {
    param_code: 'company_announcement_public',
    param_name: '施設向けpublicお知らせ',
    value_int: '',
    value_text: '',
    applied_date: Time.zone.parse('2000/01/01')
  },
  {
    param_code: 'company_announcement',
    param_name: '登録施設向けお知らせ',
    value_int: '',
    value_text: '',
    applied_date: Time.zone.parse('2000/01/01')
  },
  {
    param_code: 'partner_announcement',
    param_name: 'パートナー向けお知らせ',
    value_int: '',
    value_text: '',
    applied_date: Time.zone.parse('2000/01/01')
  },
].each do |data|
  SystemParameter.create!(data)
end
