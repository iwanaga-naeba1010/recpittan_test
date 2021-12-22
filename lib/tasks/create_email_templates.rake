require 'csv'

# rake import:email_templates
namespace :import do
  task email_templates: :environment do
    puts "start to create email_templates data"
    begin
      CSV.foreach('db/email_templates.csv', encoding: 'Shift_JIS:UTF-8', headers: true) do |row|
        EmailTemplate.find_or_create_by(kind: row['kind']) do |et|
          et.explanation = row["explanation"]
          et.body =  row["body"]
          et.title = row["title"]
          et.signature = row["signature"]
          et.kind = row["kind"]
        end
      end
      puts "completed!!"
    rescue ActiveModel::UnknownAttributeError => invalid
      puts "raised error : unKnown attribute "
    end
  end
end
