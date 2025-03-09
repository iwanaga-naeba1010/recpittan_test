# frozen_string_literal: true

module NumberCodes
  class GeneratePlanYearCodeService
    attr_reader :registration_year

    def initialize(registration_year = Time.zone.today.year.to_s)
      @registration_year = registration_year
    end

    def execute
      ActiveRecord::Base.transaction do
        numbering_data = MNumbering.facility.year.find_or_initialize_by(numbering_datetime: registration_year)
        numbering_value = next_available_number(numbering_data)

        unless numbering_data.persisted?
          numbering_data.assign_attributes(
            numbering_value: numbering_value,
            code_name: '',
            code: ''
          )
          numbering_data.save!
        end

        formatted_code(numbering_value)
      end
    end

    private

    def next_available_number(numbering_data)
      numbering_data.persisted? ? numbering_data.numbering_value + 1 : 1
    end

    def formatted_code(numbering_value)
      "P#{registration_year}-#{format_number(numbering_value)}"
    end

    def format_number(value)
      value.to_s.rjust(4, '0')
    end
  end
end
