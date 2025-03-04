# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderDecorator do
  let(:partner) { create(:user, :with_recreations) }
  let(:customer) { create(:user, :with_customer) }
  let(:order) { create(:order, recreation_id: partner.recreations.first.id, user_id: customer.id) }
  let(:decorated_order) { order.decorate }

  describe '#facility_id' do
    subject { decorated_order.facility_id }

    context 'when the customer has a company' do
      it { is_expected.to eq(customer.company.id) }
    end

    context 'when the customer has no company' do
      let(:customer) { create(:user) }
      it { is_expected.to be_nil }
    end
  end

  describe '#facility_name' do
    subject { decorated_order.facility_name }

    context 'when the customer has a company' do
      it { is_expected.to eq(customer.company.facility_name) }
    end

    context 'when the customer has no company' do
      let(:customer) { create(:user) }
      it { is_expected.to be_nil }
    end
  end

  shared_context 'order with financial data' do
    let(:order) do
      instance_double(
        'Order',
        total_partner_payment_with_tax: total_partner_payment_with_tax,
        transportation_expenses: transportation_expenses,
        total_additional_facility_fee: total_additional_facility_fee,
        partner_fee_rate: partner_fee_rate
      )
    end
    let(:decorated_order) { described_class.new(order) }
  end

  describe '#partner_fee_base_amount' do
    include_context 'order with financial data'

    subject { decorated_order.partner_fee_base_amount }

    context 'when all values are present' do
      let(:total_partner_payment_with_tax) { 5000 }
      let(:transportation_expenses) { 1000 }
      let(:total_additional_facility_fee) { 500 }
      let(:partner_fee_rate) { 1.1 } # Ensure partner_fee_rate is defined

      it { is_expected.to eq(3500) }
    end

    context 'when some values are nil' do
      let(:total_partner_payment_with_tax) { 5000 }
      let(:transportation_expenses) { nil }
      let(:total_additional_facility_fee) { 500 }
      let(:partner_fee_rate) { 1.1 }

      it { is_expected.to eq(4500) }
    end

    context 'when all values are nil' do
      let(:total_partner_payment_with_tax) { nil }
      let(:transportation_expenses) { nil }
      let(:total_additional_facility_fee) { nil }
      let(:partner_fee_rate) { 1.1 }

      it { is_expected.to eq(0) }
    end
  end

  describe '#partner_fee_with_tax' do
    include_context 'order with financial data'

    subject { decorated_order.partner_fee_with_tax }

    context 'when base amount and rate are present' do
      let(:total_partner_payment_with_tax) { 5000 }
      let(:transportation_expenses) { 1000 }
      let(:total_additional_facility_fee) { 500 }
      let(:partner_fee_rate) { 1.1 }

      it { is_expected.to eq(3850) } # 3500 * 1.1 = 3850
    end

    context 'when rate is nil' do
      let(:total_partner_payment_with_tax) { 5000 }
      let(:transportation_expenses) { 1000 }
      let(:total_additional_facility_fee) { 500 }
      let(:partner_fee_rate) { nil }

      it { is_expected.to eq(0) }
    end

    context 'when base amount is 0' do
      let(:total_partner_payment_with_tax) { nil }
      let(:transportation_expenses) { nil }
      let(:total_additional_facility_fee) { nil }
      let(:partner_fee_rate) { 1.1 }

      it { is_expected.to eq(0) }
    end
  end

  describe '#display_is_managercontrol' do
    context 'when is_managercontrol is true' do
      before do
        allow(order).to receive(:is_managercontrol?).and_return(true)
      end

      it 'returns a span with the text "運営管理" and class "pink"' do
        status_tag = decorated_order.display_is_managercontrol
        expect(status_tag).to have_selector('span.status_tag.運営管理.pink', text: '運営管理')
      end
    end

    context 'when is_managercontrol is false' do
      before do
        allow(order).to receive(:is_managercontrol?).and_return(false)
      end

      it 'returns nil' do
        expect(decorated_order.display_is_managercontrol).to be_nil
      end
    end
  end

  describe '#display_order_header' do
    let(:text_is_managercontrol) { '運営管理' }
    let(:recreation_title) { 'Recreation Title' }
    let(:case_id_text) { '案件id : #' }

    context 'when is_managercontrol is true' do
      before do
        allow(order).to receive(:is_managercontrol?).and_return(true)
        allow(decorated_order).to receive(:recreation_title).and_return(recreation_title)
      end

      it 'returns the header correct format and with is_managercontrol status' do
        header = decorated_order.display_order_header
        expect(header).to include(case_id_text)
        expect(header).to include(recreation_title)
        expect(header).to include(text_is_managercontrol)
      end
    end

    context 'when is_managercontrol is false' do
      before do
        allow(order).to receive(:is_managercontrol?).and_return(false)
        allow(decorated_order).to receive(:recreation_title).and_return(recreation_title)
      end

      it 'returns the header correct format and without is_managercontrol status' do
        header = decorated_order.display_order_header
        expect(header).to include(case_id_text)
        expect(header).to include(recreation_title)
        expect(header).not_to include(text_is_managercontrol)
      end
    end
  end
end
