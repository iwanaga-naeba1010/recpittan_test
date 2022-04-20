# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders', js: true, type: :system do
  let(:user) { create :user, :with_custoemr }
  let(:partner) { create :user, :with_recreations }
  let(:recreation) { partner.recreations.first }
  let(:order) { create :order, :with_order_dates, recreation_id: recreation.id, user_id: user.id }

  before do
    sign_in user
  end

  context 'customers_orders_chat' do
    before do
      visit chat_customers_order_path(order)
    end

    feature '' do
      scenario '' do
        input = {
          user: {
            email: 'test@gmail.com',
            password: '11111111'
          },
          recreation: {
            regular_material_price: 10000,
            regular_price: 1000
          },
          order: {
            expenses: 10000,
            transportation_expenses: 5000,
            regular_material: 10,
            number_of_facilities: 3
          }
        }

        input_text_boxes('#expenses', input[:order][:expenses])
        input_text_boxes('#transportationExpenses', input[:order][:transportation_expenses])
        input_text_boxes('#numberOfFacilities', input[:order][:number_of_facilities])
      end
    end
  end
end
