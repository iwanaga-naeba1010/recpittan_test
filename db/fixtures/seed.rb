file_names = %w[
  users.rb
  categories.rb
  events.rb
  targets.rb
  recreations.rb
]

dir = Rails.root.join('db', 'fixtures', 'development', 'seeds')
file_names.each do |file_name|
  puts "== Seed from #{dir}/#{file_name}"
  require "#{dir}/#{file_name}"
end
