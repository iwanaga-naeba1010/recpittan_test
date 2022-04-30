# frozen_string_literal: true

namespace :migrate_is_public_to_status_to_recreation do
  task run: :environment do
    ActiveRecord::Base.transaction do
      recreations = Recreation.all

      recreations.each do |rec|
        rec.update!(status: rec.is_public == true ? :published : :unapplied)
      end
    end
  rescue StandardError => e
    puts e
  end
end
