# frozen_string_literal: true

module Pdfs
  class PdfGenerator
    attr_reader :pdf_engine, :configurator

    def initialize(pdf_engine: WickedPdf.new, configurator: OptionsConfigurator.new)
      @pdf_engine = pdf_engine
      @configurator = configurator
    end

    def generate_from_html(html, options = {})
      raise ArgumentError, 'HTML content cannot be blank' if html.blank?

      pdf_options = configurator.configure(options)

      begin
        pdf_engine.pdf_from_string(html, pdf_options)
      rescue StandardError => e
        Rails.logger.error "Error generating PDF: #{e.message}"
        raise
      end
    end
  end
end
