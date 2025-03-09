# frozen_string_literal: true

# == Schema Information
#
# Table name: recreations
#
#  id                      :bigint           not null, primary key
#  additional_facility_fee :integer          default(2000)
#  amount                  :integer
#  base_code               :string
#  borrow_item             :text
#  bring_your_own_item     :text
#  capacity                :integer
#  category                :integer          default("event"), not null
#  description             :text
#  extra_information       :text
#  flow_of_day             :text
#  flyer_color             :string
#  is_public_price         :boolean          default(TRUE)
#  is_withholding_tax      :boolean          default(FALSE)
#  kind                    :integer          default("visit"), not null
#  material_amount         :integer
#  material_price          :integer
#  memo                    :string
#  minutes                 :integer
#  number_of_past_events   :integer          default(0), not null
#  price                   :integer
#  second_title            :string
#  status                  :integer          default("unapplied"), not null
#  title                   :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :bigint           not null
#  youtube_id              :string
#
# Indexes
#
#  index_recreations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Recreation, type: :model do
  it { is_expected.to have_db_column(:is_withholding_tax).of_type(:boolean).with_options(default: false, null: true) }
end
