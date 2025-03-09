# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NumberCodes::GeneratePartnerYearCodeService, type: :service do
  let(:registration_year) { '2025' }
  let(:code) { 'code' }
  let(:code_name) { 'code_name' }
  let(:subject) { described_class.new(code, code_name, registration_year).execute }

  context 'when no numbering data exists' do
    it 'creates a new numbering record and returns the correct code' do
      expect { subject }.to change { MNumbering.count }.by(1)
      expect(subject).to eq("RP#{registration_year}-000001")
    end
  end

  context 'when numbering data already exists' do
    let!(:numbering_data) do
      MNumbering.partner.year.create!(
        numbering_datetime: registration_year,
        numbering_value: 5,
        code_name: code_name,
        code: code
      )
    end

    it 'increments the numbering_value by 1' do
      expect(subject).to eq("RP#{registration_year}-000006")
    end
  end

  context 'when there is a conflicting trading_target_code' do
    before do
      MNumbering.partner.year.create!(
        numbering_datetime: registration_year,
        numbering_value: 5,
        code_name: 'another_code_name',
        code: 'another_code'
      )
      create(:company, trading_target_code: '000006')
    end

    it 'skips the conflicting number and returns the next available one' do
      expect(subject).to eq('RP2025-000007')
    end
  end
end
