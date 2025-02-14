# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NumberCodes::GenerateFacilityYearCodeService, type: :service do
  let(:registration_year) { '2025' }
  let(:code) { 'code' }
  let(:subject) { described_class.new(code, registration_year).execute }

  context 'when no numbering data exists' do
    it 'creates a new numbering record and returns the correct code' do
      expect { subject }.to change { MNumbering.count }.by(1)
      expect(subject).to eq("P#{registration_year}-#{code}-0001")
    end
  end

  context 'when numbering data already exists' do
    let!(:numbering_data) do
      MNumbering.facility.year.create!(
        numbering_datetime: registration_year,
        numbering_value: 5,
        code: code,
        code_name: ''
      )
    end

    it 'increments the numbering_value by 1' do
      expect(subject).to eq("P#{registration_year}-#{code}-0006")
    end
  end
end
