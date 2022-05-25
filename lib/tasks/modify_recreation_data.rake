# frozen_string_literal: true

require 'csv'

namespace :modify_recreation_data do
  task run: :environment do
    ActiveRecord::Base.transaction do
      recreations = Recreation.all.to_a
      path = Rails.root.join('lib/tasks/recreations.csv')
      CSV.foreach(path, headers: true) do |row|
        rec = recreations.select { |elm| elm.id == row[0].to_i }.first
        next if rec.blank?

        rec.update!(
          title: row[1],
          second_title: row[2],
          minutes: row[3],
          description: row[4],
          flow_of_day: row[5],
          borrow_item: row[6],
          bring_your_own_item: row[7],
          extra_information: row[8],
          youtube_id: row[11],
          price: row[13],
          material_price: row[14],
          material_amount: row[15],
          capacity: row[16],
          amount: row[17],
          additional_facility_fee: row[27],
          category: row[28].to_sym,
          status: row[29],
          kind: row[30]
        )

        next if row[31].blank?

        if row[31] == '全国'
          RecreationPrefecture.names.map { |name| rec.recreation_prefectures.build(name: name) }
        else
          names = row[31].split('・')
          names.map { |name| rec.recreation_prefectures.build(name: name) }
        end

        rec.save!
      end
    end
  rescue StandardError => e
    puts e
  end
end
