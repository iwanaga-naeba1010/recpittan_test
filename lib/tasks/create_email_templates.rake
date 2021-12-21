require 'csv'

# rake import:email_templates
namespace :import do
  task email_templates: :environment do
    list = []
    CSV.foreach('db/email_templates.csv', encoding: 'Shift_JIS:UTF-8', headers: true) do |row|
      list << {
        id:  row["id"],
        explanation: row["explanation"],
        body: row["body"],
        title: row["title"],
        signature: row["signature"],
        kind: row["kind"]
      }
    end
    puts "start to create email_templates data"
    begin
      EmailTemplate.create!(list)
      puts "completed!!"
    rescue ActiveModel::UnknownAttributeError => invalid
      puts "raised error : unKnown attribute "
    end
  end
end
