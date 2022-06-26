# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resources::InvoiceInformations::Create, type: :interaction do
  describe '#execute' do
    let!(:customer) { create(:user) }
    let(:params) do
      {
        name: 'テスト会社',
        zip: '450-6001',
        prefecture: '愛知県',
        city: '名古屋市',
        street: '中村区名駅ＪＲセントラルタワーズ',
        building: ''
      }
    end

    subject do
      Resources::InvoiceInformations::Create.run!(
        params: params,
        current_user: customer
      )
    end

    it 'should create a invoice_information' do
      expect { subject }.to change { InvoiceInformation.count }.from(0).to(1)
    end
  end
end
