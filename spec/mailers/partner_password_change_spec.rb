# frozen_string_literal: true

require 'rake'
require 'rails_helper'

RSpec.describe PartnerPasswordChangeMailer, type: :mailer do
  let!(:template) { create :email_template, kind: 'partner_password_change' }
  let(:customer) { create :user, :with_customer }

  before :all do
    Rails.application.load_tasks
    Rake::Task['import:email_templates'].invoke
  end

  describe 'chat_start' do
    let(:mail) { PartnerPasswordChangeMailer.notify(customer) }

    # it 'renders the subject' do
    #   expect(mail.subject).to eq(template.title)
    # end

    it 'renders the reciever email' do
      expect(mail.to).to eq([customer.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['info@everyplus.jp'])
    end

    # it 'renders the body' do
    #   expect(mail.body.parts.first.decoded).to match('MyText')
    # end
  end
end
