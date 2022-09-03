# frozen_string_literal: true

require 'csv'
require 'logger'

namespace :add_number_of_past_events do
  task run: :environment do
    path = Rails.root.join('number_of_past_events.csv')

    begin
      CSV.parse(File.read(path), headers: true).map do |row|
        recreation = Recreation.find_by(id: row[0].to_i)
        next if recreation.blank?

        recreation.update!(number_of_past_events: row[1].to_i)
      end
    rescue StandardError => e
      puts e
      logger.error(e)
    end

    logger.debug('Finished task!')
  end

  def logger
    Logger.new($stdout)
  end
end
