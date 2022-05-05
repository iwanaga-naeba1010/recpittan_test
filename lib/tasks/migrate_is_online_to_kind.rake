# frozen_string_literal: true

namespace :restore_tags do
  task run: :environment do
    ActiveRecord::Base.transaction do
      recreations = Recreation.all
      recreations.each do |rec|
        rec.update!(kind: rec.is_online == true ? :online : :visit)
      end
    end
  rescue StandardError => e
    puts e
  end
end
