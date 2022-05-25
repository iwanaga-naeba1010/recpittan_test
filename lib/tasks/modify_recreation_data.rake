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
          other: row[8]
        )
      end
    end
  rescue StandardError => e
    puts e
  end
end
