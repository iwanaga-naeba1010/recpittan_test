# frozen_string_literal: true
require 'tempfile'

namespace :separate_profile do
  task run: :environment do
    ActiveRecord::Base.transaction do
      recreations = Recreation.all

      recreations.each do |rec|
        name = rec.instructor_name.squish.empty? ? rec.title : rec.instructor_name
        profile = rec.user.profiles.find_or_create_by!(name: name) do |p|
          p.position = rec.instructor_position
          p.title = rec.instructor_title
          p.description = rec.instructor_description
          if rec.instructor_image.present?

            # TODO(okubo): 画像を保存してから参照、であれば問題ないが残ってしまうので完了したら削除する
            image = File.binwrite(Rails.root.join("public/#{rec.instructor_image.file.filename}"), rec.instructor_image.file.read)
            p.image = File.open(Rails.root.join("public/#{rec.instructor_image.file.filename}"))
          end

        end

        rec.build_recreation_profile(profile: profile)
        rec.save!
      end
    end
  rescue StandardError => e
    puts e
  end
end
