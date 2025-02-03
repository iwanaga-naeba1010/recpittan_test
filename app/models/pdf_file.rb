# == Schema Information
#
# Table name: pdf_files
#
#  id         :bigint           not null, primary key
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class PdfFile < ApplicationRecord
  mount_uploader :file, PdfUploader

  validates :file, presence: true
end
