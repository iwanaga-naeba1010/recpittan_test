# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecreationsHelper, type: :helper do
  let(:customer) { create :user }
  let(:partner) { create :user, role: :partner }

  describe 'price_pipe' do
    context 'with valid parameters' do
      it 'renders price when customer user logged in' do
        input_price = 10000
        output = number_to_currency(input_price)

        func_result = helper.price_pipe(input_price, customer)
        expect(func_result).to eq(output)
      end

      it 'does not renders price when user not logged in' do
        input_price = 10000
        output = 'お問い合せください'

        func_result = helper.price_pipe(input_price, nil)
        expect(func_result).to eq(output)
      end

      it 'does not renders price when partner user not logged in' do
        input_price = 10000
        output = 'お問い合せください'

        func_result = helper.price_pipe(input_price, nil)
        expect(func_result).to eq(output)
      end

    end
  end
end
