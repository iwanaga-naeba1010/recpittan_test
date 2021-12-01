namespace :update_confirmed_at do
  task run: :environment do
    users = User.all
    ActiveRecord::Base.transaction do
      users.each do |user|
        if user.update(confirmed_at: Time.current)
        else
          raise StandardError
        end
      end
    end
  rescue StandardError => e
    puts e
  end
end
