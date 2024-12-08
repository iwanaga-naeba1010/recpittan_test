# frozen_string_literal: true

class ChatFileUploader < ImageUploader
  def extension_allowlist
    %w[jpg jpeg gif png pdf pptx ppt]
  end
end
