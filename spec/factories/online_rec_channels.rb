# frozen_string_literal: true

# == Schema Information
#
# Table name: online_rec_channels
#
#  id                  :bigint           not null, primary key
#  calendar_field_memo :text
#  image               :text
#  period              :date             not null
#  status              :integer          not null
#  zoom_field_memo     :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :online_rec_channel do
    image do
      ActionDispatch::Http::UploadedFile.new(
        filename: 'test.png',
        type: 'image/png',
        tempfile: Rails.root.join('spec/files/test.png').open
      )
    end
    status { 0 }
    period { '2023-03-13' }
    calendar_field_memo { 'MyText' }
    zoom_field_memo { 'MyText' }
  end
end
