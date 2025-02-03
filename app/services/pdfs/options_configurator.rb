# frozen_string_literal: true

module Pdfs
  class OptionsConfigurator
    DEFAULT_OPTIONS = {
      footer: { center: 'Page [page] of [topage]', font_size: 8 }
    }

    def configure(options = {})
      options[:footer] = DEFAULT_OPTIONS[:footer].merge(options[:footer] || {})
      options
    end
  end
end
