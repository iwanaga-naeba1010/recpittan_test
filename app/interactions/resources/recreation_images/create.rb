# frozen_string_literal: true

module Resources
  module RecreationImages
    class Create < ActiveInteraction::Base
      hash :params do
        string :image
        string :filename
        symbol :kind
      end

      integer :recreation_id

      validates :recreation_id, presence: true
      validate :validate_params

      def execute
        ActiveRecord::Base.transaction do
          image = RecreationImage.new(
            recreation_id:,
            image: base64_conversion(params[:image]),
            filename: params[:filename],
            kind: params[:kind]
          )
          image.document_kind = image.kind_value
          image.save!
          image
        end
      rescue ActiveRecord::RecordInvalid => e
        errors.merge!(e.record.errors)
      end

      private def base64_conversion(uri_str, filename = 'base64')
        image_data = split_base64(uri_str)
        image_data_string = image_data[:data]
        image_data_binary = Base64.decode64(image_data_string)

        temp_img_file = Tempfile.new(filename)
        temp_img_file.binmode
        temp_img_file << image_data_binary
        temp_img_file.rewind

        img_params = {
          filename: "#{filename}.#{image_data[:extension]}",
          type: image_data[:type],
          tempfile: temp_img_file
        }
        ActionDispatch::Http::UploadedFile.new(img_params)
      end

      private def split_base64(uri_str)
        return nil unless uri_str.match(/data:(.*?);(.*?),(.*)$/)

        uri = {}
        uri[:type] = Regexp.last_match(1)
        uri[:encoder] = Regexp.last_match(2)
        uri[:data] = Regexp.last_match(3)
        uri[:extension] = Regexp.last_match(1).split('/')[1]
        uri
      end

      private def validate_params
        if params[:filename].blank?
          errors.add(:filename, 'ファイル名は必須です')
        end

        if params[:kind].blank?
          errors.add(:kind, 'KINDは必須です')
        end
      end
    end
  end
end
