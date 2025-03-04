# frozen_string_literal: true

class OrderDecorator < ApplicationDecorator
  # 施設
  delegate :id, :zip, :prefecture, :city, :street, :building, to: :'user.company', allow_nil: true, prefix: :facility
  delegate :facility_name, to: :user, allow_nil: true

  # パートナー情報
  delegate :id, to: :'recreation.user', allow_nil: true, prefix: :recreation_user
  delegate :name, to: :'recreation.profile', allow_nil: true, prefix: :recreation_profile
  delegate :id, :title, to: :recreation, allow_nil: true, prefix: :recreation

  def partner_fee_base_amount
    # 計算: パートナー謝礼全体（税込） - 交通費 - 追加施設費合計
    total = safe_to_i(object.total_partner_payment_with_tax)
    expenses = safe_to_i(object.transportation_expenses)
    additional_fee = safe_to_i(object.total_additional_facility_fee)

    total - expenses - additional_fee
  end

  def partner_fee_with_tax
    # 計算: パートナー手数料計算金額 x パートナー手数料率（四捨五入）
    safe_multiply_and_round(partner_fee_base_amount, object.partner_fee_rate)
  end

  def display_is_managercontrol
    return unless object.is_managercontrol?

    status_tag('運営管理', class: 'pink')
  end

  def display_order_header
    h.safe_join([
      '案件id : #',
      object.id,
      recreation_title,
      ' ',
      display_is_managercontrol
    ])
  end

  private

  def safe_to_i(value)
    value.to_i
  end

  def safe_multiply_and_round(amount, rate)
    return 0 unless amount && rate

    (amount.to_f * rate.to_f).round
  end
end
