# frozen_string_literal: true

# == Schema Information
#
# Table name: order_desire_dates
#
#  id          :bigint           not null, primary key
#  desire_date :date
#  desire_no   :integer
#  time_from   :time
#  time_to     :time
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  order_id    :bigint           not null
#
# Indexes
#
#  index_order_desire_dates_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#
require 'rails_helper'

RSpec.describe OrderDesireDate, type: :model do
  let(:order) { create(:order) }

  describe 'validations' do
    subject { build(:order_desire_date, order:, desire_no:, desire_date: Time.zone.today, time_from: '10:00', time_to: '12:00') }

    context 'when desire_no is between 1 and 3' do
      [1, 2, 3].each do |valid_no|
        let(:desire_no) { valid_no }

        it "is valid when desire_no is #{valid_no}" do
          expect(subject).to be_valid
        end
      end
    end

    context 'when desire_no is outside the range of 1 to 3' do
      [-1, 0, 4, 5, nil].each do |invalid_no|
        let(:desire_no) { invalid_no }

        it "is invalid when desire_no is #{invalid_no.inspect}" do
          expect(subject).to be_invalid
        end
      end
    end
  end
end
