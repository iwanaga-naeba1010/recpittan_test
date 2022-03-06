# frozen_string_literal: true

class ChatFileUploader < ImageUploader
  def extension_whitelist
    %w[jpg jpeg gif png pdf pptx ppt]
  end
end
