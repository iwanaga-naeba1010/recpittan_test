# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SystemParameterDecorator do
  let(:subject) { create(:system_parameter, applied_date: applied_date).decorate }

  describe '#applied_date_formatted' do
    context 'when applied_date is present' do
      let(:applied_date) { Date.new(2025, 2, 11) }

      it 'returns formatted date' do
        expect(subject.applied_date_formatted).to eq('2025/02/11')
      end
    end

    context 'when applied_date is nil' do
      let(:applied_date) { nil }

      it 'returns nil' do
        expect(subject.applied_date_formatted).to be_nil
      end
    end
  end
end
