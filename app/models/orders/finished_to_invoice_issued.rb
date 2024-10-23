# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                      :bigint           not null, primary key
#  additional_facility_fee :integer          default(0)
#  amount                  :integer          default(0)
#  building                :string
#  city                    :string
#  contract_number         :string
#  coupon_code             :string
#  end_at                  :datetime
#  expenses                :integer          default(0)
#  final_check_status      :integer
#  is_accepted             :boolean          default(FALSE)
#  is_open                 :boolean          default(TRUE), not null
#  material_amount         :integer          default(0)
#  material_price          :integer          default(0)
#  memo                    :string
#  number_of_facilities    :integer
#  number_of_people        :integer
#  prefecture              :string
#  price                   :integer          default(0)
#  start_at                :datetime
#  status                  :integer
#  street                  :string
#  support_price           :integer          default(0)
#  transportation_expenses :integer          default(0)
#  zip                     :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  recreation_id           :bigint           not null
#  user_id                 :bigint           not null
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
class Orders::FinishedToInvoiceIssued < Order
  # NOTE(okubo): 完了から請求書発行済みに強制移行するために機能
  default_scope { where(status: :finished) }
end
