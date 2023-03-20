# frozen_string_literal: true

# == Schema Information
#
# Table name: online_recreation_channels
#
#  id            :bigint           not null, primary key
#  calendar_memo :text
#  image         :text
#  period        :date             not null
#  status        :integer          not null
#  zoom_memo     :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :online_recreation_channel do
    image do
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
  end
end
