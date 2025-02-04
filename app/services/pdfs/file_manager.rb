# frozen_string_literal: true

module Pdfs
  class FileManager
    def ensure_directory(directory)
      FileUtils.mkdir_p(directory)
    end

    def save(filename, content)
      File.binwrite(filename, content)
    end

    def delete_file(filename)
      if File.exist?(filename)
        File.delete(filename)
        Rails.logger.info "Deleted file: #{filename}"
      else
        Rails.logger.warn "File not found: #{filename}"
      end
    end
  end
end
