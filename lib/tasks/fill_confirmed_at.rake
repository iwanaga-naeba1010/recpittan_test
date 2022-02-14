# frozen_string_literal: true

# NOTE(okubo): confirmed_atが入っていない場合、nilのuserのみ日付入れるバッチ
require 'csv'

namespace :fill_confirmed_at do
  task run: :environment do
    users = User.where(confirmed_at: nil)
    users.map { |user| user.update(confirmed_at: DateTime.current) }

  rescue StandardError => e
    puts e
  end
end
