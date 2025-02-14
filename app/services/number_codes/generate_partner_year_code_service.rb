# frozen_string_literal: true

module NumberCodes
  class GeneratePartnerYearCodeService
    attr_reader :registration_year, :code, :code_name

    def initialize(code, code_name, registration_year = Time.zone.today.year.to_s)
      @registration_year = registration_year
      @code = code
      @code_name = code_name
    end

    def execute
      ActiveRecord::Base.transaction do
        numbering_data = MNumbering.partner.year.find_or_initialize_by(numbering_datetime: registration_year)
        numbering_value = next_available_number(numbering_data)

        unless numbering_data.persisted?
          numbering_data.assign_attributes(
            numbering_value: numbering_value,
            code_name: code_name,
            code: code
          )
          numbering_data.save!
        end

        formatted_code(numbering_value)
      end
    end

    private

    def next_available_number(numbering_data)
      value = numbering_data.persisted? ? numbering_data.numbering_value + 1 : 1
      value += 1 while trading_target_code_taken?(value)
      value
    end

    def trading_target_code_taken?(numbering_value)
      Company.exists?(trading_target_code: format_number(numbering_value))
    end

    def formatted_code(numbering_value)
      "RP#{registration_year}-#{format_number(numbering_value)}"
    end

    def format_number(value)
      value.to_s.rjust(6, '0')
    end
  end
end
