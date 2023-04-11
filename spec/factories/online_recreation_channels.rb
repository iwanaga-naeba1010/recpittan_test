# frozen_string_literal: true

# == Schema Information
#
# Table name: online_recreation_channels
#
#  id             :bigint           not null, primary key
#  calendar_image :text
#  calendar_memo  :text
#  calendar_pdf   :text
#  flyer_image    :text
#  flyer_pdf      :text
#  period         :date             not null
#  status         :integer          not null
#  top_image      :text
#  zoom_memo      :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :online_recreation_channel do
    top_image do
      ActionDispatch::Http::UploadedFile.new(
        filename: 'test.png',
        type: 'image/png',
        tempfile: Rails.root.join('spec/files/test.png').open
      )
    end
    status { 0 }
    period { '2023-03-13' }
    calendar_memo { 'MyText' }
    zoom_memo { 'MyText' }
    calendar_image do
      ActionDispatch::Http::UploadedFile.new(
        filename: 'test.png',
        type: 'image/png',
        tempfile: Rails.root.join('spec/files/test.png').open
      )
    end
    calendar_pdf do
      ActionDispatch::Http::UploadedFile.new(
        filename: 'test.pdf',
        type: 'image/pdf',
        tempfile: Rails.root.join('spec/files/test.pdf').open
      )
    end
  end
end
