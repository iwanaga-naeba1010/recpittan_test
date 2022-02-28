# frozen_string_literal: true

class Customers::RecreationFilesController < Customers::ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :require_customer

  def download
    file = RecreationFile.find(params[:id])
    return if file.blank?

    send_file(
      file.source.read,
      filename: file.source.identifier,
      type: file.source.content_type,
      dispotion: 'attachment'
    )
  end
end
