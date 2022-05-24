# frozen_string_literal: true

require 'rake'
require 'rails_helper'

RSpec.describe CustomerChatMailer, type: :mailer do
  # let!(:template) { create :email_template, kind: 'customer_chat' }
  let!(:template) { EmailTemplate.find_by(kind: 'customer_chat') }
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_customer }
  let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }

  # before :all do
  #   Rails.application.load_tasks
  #   Rake::Task['load_email_templates:run'].invoke
  # end
  describe 'chat_start' do
    let(:mail) { CustomerChatMailer.notify(order: order) }

    it 'renders the subject' do
      expect(mail.subject).to eq(template.title)
    end

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
