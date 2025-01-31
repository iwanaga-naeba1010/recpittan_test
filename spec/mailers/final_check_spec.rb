# frozen_string_literal: true

require 'rake'
require 'rails_helper'

RSpec.describe FinalCheckMailer, type: :mailer do
  let(:partner) { create(:user, :with_recreations) }

  let(:order) do
    create(:order,
           start_at: Time.zone.parse('2025-02-01 10:00'),
           user: create(:user, company: create(:company, facility_name: 'テスト施設')),
           recreation: create(:recreation, user: partner))
  end

  let(:mail) { FinalCheckMailer.notify(order:) }
  let(:template) { FinalCheckMailer.new.send(:template_by_kind, kind: 'final_check') }

  let(:expected_subject) do
    format(template['title'],
           start_at: order.start_at.strftime('%Y.%m.%d %H:%M'),
           facility_name: order.user.company.facility_name)
  end

  it 'renders the subject' do
    expect(mail.subject).to eq(expected_subject)
  end

  it 'renders the receiver email' do
    expect(mail.to).to eq([partner.email])
  end

  it 'renders the sender email' do
    expect(mail.from).to eq(['info@everyplus.jp'])
  end
end
