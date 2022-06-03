# frozen_string_literal: true

require 'rake'
require 'rails_helper'

RSpec.describe ReportDenyMailer, type: :mailer do
  include_context 'with email templates'
  let!(:template) { templates.find { |t| t['kind'] == 'report_deny' } }
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_customer }
  # NOTE(okubo): メール送信前に用意することでnilエラーを回避
  let!(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }
  let!(:report) { create :report, order_id: order.id }

  describe 'chat_start' do
    let(:mail) { ReportDenyMailer.notify(order: order) }

    # NOTE: 管理画面で変更するためテスト不要
    it 'renders the subject' do
      expect(mail.subject).to eq(template['title'])
    end

    it 'renders the reciever email' do
      expect(mail.to).to eq([partner.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['info@everyplus.jp'])
    end

    # it 'renders the body' do
    #   expect(mail.body.parts.first.decoded).to match('MyText')
    # end
  end
end
