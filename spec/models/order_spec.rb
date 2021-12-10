# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                      :bigint           not null, primary key
#  building                :string
#  city                    :string
#  date_and_time           :datetime
#  expenses                :integer
#  is_accepted             :boolean          default(FALSE)
#  number_of_people        :integer
#  prefecture              :string
#  status                  :integer
#  street                  :string
#  transportation_expenses :integer
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
require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_custoemr }
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
    end
  end
end
