# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Whenever schedule', type: :task do
  let(:whenever_output) { `bundle exec whenever --load-file config/schedule.rb` }

  it 'schedules update_held_order:run every hour' do
    expect(whenever_output).to include('update_held_order:run').and include('0 * * * *')
  end

  it 'schedules send_final_check_mail:run every day at 9:00 AM' do
    expect(whenever_output).to include('send_final_check_mail:run').and include('0 9 * * *')
  end

  it 'schedules sitemap:refresh every day at 00:00 AM' do
    expect(whenever_output).to include('sitemap:refresh').and include('0 0 * * *')
  end
end
