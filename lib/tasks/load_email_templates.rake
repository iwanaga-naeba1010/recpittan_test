# frozen_string_literal: true

require 'yaml'

namespace :load_email_templates do
  task run: :environment do
    ActiveRecord::Base.transaction do
      EmailTemplate.all.destroy_all
      path = Rails.root.join('lib/tasks/email_template.yml')
      templates = YAML.load_file(path)
      templates.each do |template|
        EmailTemplate.create!(
          title: template['title'],
          explanation: template['explanation'],
          kind: template['kind'],
          body: template['body']
        )
      end
    end
  rescue StandardError => e
    puts e
  end
end
