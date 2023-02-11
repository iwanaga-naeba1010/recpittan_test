# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resources::InvoiceInformations::Update, type: :interaction do
  describe '#execute' do
    let!(:customer) { create(:user) }
    let!(:invoice_information) { create(:invoice_information, user: customer) }
    let(:params) do
      {
        company_name: 'テスト会社',
        name: '大久保',
        email: 'hogehoge@example.com',
        zip: '450-6001',
        prefecture: '愛知県2',
        city: '名古屋市2',
        street: '中村区名駅ＪＲセントラルタワーズ2',
        building: 'test2',
        code: 'test2',
        memo: 'memo2'
      }
    end

    subject do
      Resources::InvoiceInformations::Update.run!(
        id: invoice_information.id,
        params:,
        current_user: customer
      )
    end

    it 'should update name' do
      expect { subject }
        .to change { InvoiceInformation.find(invoice_information.id).name }
        .from(invoice_information.name).to(params[:name])
    end
    it 'should update zip' do
      expect { subject }
        .to change { InvoiceInformation.find(invoice_information.id).zip }
        .from(invoice_information.zip).to(params[:zip])
    end
    it 'should update prefecture' do
      expect { subject }
        .to change { InvoiceInformation.find(invoice_information.id).prefecture }
        .from(invoice_information.prefecture).to(params[:prefecture])
    end
    it 'should update city' do
      expect { subject }
        .to change { InvoiceInformation.find(invoice_information.id).city }
        .from(invoice_information.city).to(params[:city])
    end
    it 'should update street' do
      expect { subject }
        .to change { InvoiceInformation.find(invoice_information.id).street }
        .from(invoice_information.street).to(params[:street])
    end
    it 'should update building' do
      expect { subject }
        .to change { InvoiceInformation.find(invoice_information.id).building }
        .from(invoice_information.building).to(params[:building])
    end
    it 'should update memo' do
      expect { subject }
        .to change { InvoiceInformation.find(invoice_information.id).memo }
        .from(invoice_information.memo).to(params[:memo])
    end
  end
end
