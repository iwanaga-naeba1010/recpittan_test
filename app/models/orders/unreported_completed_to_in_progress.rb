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
# Foreign Keys
#
#  orders_recreation_id_fkey  (recreation_id => recreations.id)
#  orders_user_id_fkey        (user_id => users.id)
#
class Orders::UnreportedCompletedToInProgress < Order
  # NOTE(okubo): 終了報告未から相談中に強制移行するために機能
  default_scope { where(status: :unreported_completed) }
end
