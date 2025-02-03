# frozen_string_literal: true

require 'securerandom'

module Pdfs
  class ExporterService
    attr_reader :renderer, :file_manager, :pdf_generator

    def initialize(renderer: HtmlRenderer.new, file_manager: FileManager.new, pdf_generator: PdfGenerator.new)
      @renderer = renderer
      @file_manager = file_manager
      @pdf_generator = pdf_generator
    end

    def execute(data, template_name:, pdf_options: {}, debug_html: false)
      template_file = "pdfs/#{template_name}"
      pdf_name = SecureRandom.uuid
      output_dir = Rails.root.join('tmp', template_file)

      # 1. create folder to store pdf at local
      file_manager.ensure_directory(output_dir)

      # 2. render content html
      rendered_html = renderer.render(template_file, data)

      # 3. render html file for debug mode
      if debug_html
        html_debug_filename = output_dir.join("#{pdf_name}.html")
        file_manager.save(html_debug_filename, rendered_html)

        Rails.logger.info "HTML saved for debugging: #{html_debug_filename}"
      end

      # 4. convert html to pdf
      pdf_content = pdf_generator.generate_from_html(rendered_html, pdf_options)
      pdf_filename = output_dir.join("#{pdf_name}.pdf")
      file_manager.save(pdf_filename, pdf_content)
      Rails.logger.info "PDF saved at: #{pdf_filename}"

      # 5. Store pdf record
      pdf_file = PdfFile.new(file: File.open(pdf_filename))
      pdf_file.save!

      # 6. Clean files
      file_manager.delete_file(pdf_filename)
    end
  end
end
