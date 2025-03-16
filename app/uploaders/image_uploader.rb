# frozen_string_literal: true

class ImageUploader < CarrierWave::Uploader::Base
  if Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w[jpg jpeg gif png pdf pptx ppt doc docx xls xlsx]
  end

  def filename
    original_filename
  end

  def download_url
    file.url(response_content_disposition: 'attachment')
  end
end
