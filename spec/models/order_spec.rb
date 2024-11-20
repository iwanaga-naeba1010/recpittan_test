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
end
