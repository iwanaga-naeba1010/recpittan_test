# frozen_string_literal: true

require 'yaml'

namespace :load_email_templates do
  task run: :environment do
    path = Rails.root.join('lib/tasks/email_template.yml')
    templates = YAML.load_file(path)

    templates.each do |template|
      EmailTemplate.find_or_create_by(kind: template['kind']) do |et|
        et.title = template['title']
        et.explanation = template['explanation']
        et.kind = template['kind']
        et.body = template['body']
      end
    end
  end
end
