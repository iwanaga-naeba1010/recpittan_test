# frozen_string_literal: true

module Pdfs
  class HtmlRenderer
    def render(template_file, data)
      ApplicationController.render(
        template: template_file,
        layout: 'layouts/pdf',
        locals: { data: data }
      )
    end
  end
end
