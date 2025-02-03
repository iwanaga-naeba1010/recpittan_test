# frozen_string_literal: true

namespace :test_pdf_export do
  desc 'Export template1 PDF'
  task template1: :environment do
    data = [
      { name: '富美子', age: 30 },
      { name: '栞奈', age: 25 },
      { name: 'コハル', age: 25 },
      { name: '麻美', age: 25 },
    ] + Array.new(123, { name: '麻美', age: 25 })

    exporter = Pdfs::ExporterService.new
    exporter.execute(
      data,
      template_name: 'template1'
    )
  end

  desc 'Export template2 PDF'
  task template2: :environment do
    data = {}
    data[:users] = [
      { name: '富美子', age: 30 },
      { name: '栞奈', age: 25 },
      { name: 'コハル', age: 25 },
      { name: '麻美', age: 25 },
    ] + Array.new(123, { name: '麻美', age: 25 })

    pdf_options = {
      footer: { center: '[page] of [topage]' }
    }

    exporter = Pdfs::ExporterService.new
    exporter.execute(
      data,
      template_name: 'template2',
      pdf_options: pdf_options,
      debug_html: true
    )
  end
end
