# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                         :bigint           not null, primary key
#  additional_facility_fee    :integer          default(0)
#  building                   :string
#  city                       :string
#  contract_number            :string
#  end_at                     :datetime
#  expenses                   :integer          default(0)
#  final_check_status         :integer
#  instructor_amount          :integer          default(0)
#  instructor_material_amount :integer          default(0)
#  is_accepted                :boolean          default(FALSE)
#  number_of_facilities       :integer
#  number_of_people           :integer
#  prefecture                 :string
#  regular_material_price     :integer          default(0)
#  regular_price              :integer          default(0)
#  start_at                   :datetime
#  status                     :integer
#  street                     :string
#  support_price              :integer          default(0)
#  transportation_expenses    :integer          default(0)
#  zip                        :string
#  zoom_price                 :integer          default(0)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  recreation_id              :bigint           not null
#  user_id                    :bigint           not null
#
# Foreign Keys
#
#  orders_recreation_id_fkey  (recreation_id => recreations.id)
#  orders_user_id_fkey        (user_id => users.id)
#
class Orders::ForceComplete < Order
  # NOTE(okubo): 相談中から完了に強制移行するために機能なのでin_progressで対応
  default_scope { where(status: :unreported_completed) }
end
