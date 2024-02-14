# frozen_string_literal: true

namespace :plan do
  desc 'Update Recreation Prefectures from Google Sheets data'
  task update_recreation_plan: :environment do
    spreadsheet_id = '1j8o3l-z2GNMIa2qe77f752ouFVwAx3ULz_IdFGilSHY'
    titles = [
      '【月1万円代】【月1回】バルーン・大道芸・音楽・創作など',
      '【月1万代】【月1回】各種音楽・わんちゃん・お正月飾りなど',
      '【月2万代】【月2回】バルーン・己書・音楽・創作など',
      '【月2万代】【月2回】大道芸・生花・つまみ細工など',
      '【月2万代】【月2回】各種音楽・アートなど',
      '【月2万代】【月2回】わんちゃん・スイーツ・音楽・創作など',
      '【月2万代】【月1回】獅子舞ショー・スイーツ・音楽',
      '【月2万代】【月1回】マジック・漢方茶・ドッグセラピー',
      '【月2万代】【月1回×】音楽・落語・お寿司',
      '【月2万代】【月1回】コンサート・音楽・門松つくり',
      '【月1千円代】【月1回】人気の習い事（創作・趣味）',
      '【月1万代】【月1回】人気の習い事やイベント（体操・健康）',
      '【月1千円代】【月2回】人気の習い事（創作＆健康）',
      '【月1千円代】【月2回】人気の習い事2（創作＆健康）',
      '【月1千円代】【月2回】人気の習い事・イベント（創作＆健康）',
      '【月1万代】【月2回】人気の習い事3（創作＆健康）',
      '【月3万代】【月3】イベント＆創作＆健康（1月~3月おすすめ）',
      '【月3万代】【月3回】イベント＆創作＆健康（4月~6月おすすめ）',
      '【月3万代】【月3回】イベント＆創作＆健康 （7月~9月おすすめ）',
      '【月3万代】【月3回】イベント＆創作＆健康 （10月~12月おすすめ）',
    ]

    titles.each do |title|
      range = "#{title}!A:C"
      response = Google::Spreadsheets.new.get_values(spreadsheet_id, range)

      values = response.values
      recreation_plan = RecreationPlan.create!(title:, release_status: :public)

      values.each_with_index do |row, index|
        next if index < 2

        recreation = Recreation.find_by(id: row[1], status: :published)

        if recreation
          RecreationRecreationPlan.create(month: row[0].to_i, recreation_plan:,
                                          recreation:)
        end
      end
    end
  end
end
