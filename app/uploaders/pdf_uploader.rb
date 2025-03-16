# frozen_string_literal: true

class PdfUploader < ImageUploader
  def extension_allowlist
    %w[pdf]
  end
end
