# frozen_string_literal: true

class PdfUploader < CarrierWave::Uploader::Base
  if Rails.env.local?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w[pdf]
  end
end
