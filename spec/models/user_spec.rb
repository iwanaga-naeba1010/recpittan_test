# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it 'includes Devise timeoutable module' do
    expect(User.devise_modules).to include(:timeoutable)
  end

  it 'times out after 24 hours of inactivity' do
    last_access_time = 25.hours.ago
    expect(user.timedout?(last_access_time)).to be true
  end

  it 'does not time out before 24 hours' do
    last_access_time = 23.hours.ago
    expect(user.timedout?(last_access_time)).to be false
  end
end
