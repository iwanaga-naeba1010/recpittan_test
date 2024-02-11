# frozen_string_literal: true

namespace :recreation do
  desc 'Update Recreation Prefectures from Google Sheets data'
  task update_prefectures: :environment do
    spreadsheet_id = '1Z5ZWHUFfwDWwWpgvR0sdbibtgF93PGL2sLB7zfcGXDo'
    range = 'sheet1!A:H'

    response = Google::Spreadsheets.new.get_values(spreadsheet_id, range)
    values = response.values

    values.each_with_index do |row, index|
      next if index == 0

      recreation_id = row[0]
      prefecture_data = row[7]

      if prefecture_data.nil?
        puts "Prefecture data is missing for Recreation ##{recreation_id}"
        next
      end

      prefectures = prefecture_data.split(',')

      recreation = Recreation.find_by(id: recreation_id)
      if recreation
        recreation.recreation_prefectures.destroy_all

        prefectures.each do |prefecture_name|
          recreation.recreation_prefectures.create(name: prefecture_name)
        end

        puts "Updated recreation ##{recreation_id} with prefectures: #{prefectures.join(', ')}"
      else
        puts "Recreation ##{recreation_id} not found"
      end
    end
  end
end
