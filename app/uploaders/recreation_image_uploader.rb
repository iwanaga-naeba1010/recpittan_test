# frozen_string_literal: true

class RecreationImageUploader < ImageUploader
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w[jpg jpeg gif png pdf pptx ppt]
  end
end
