# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#company_announcement_public_path' do
    it 'returns the latest company announcement public path' do
      announcement = double('SystemParameter', value_text: 'public_path')
      allow(SystemParameter).to receive_message_chain(:available, :company_announcement_public, :order, :limit, :first).and_return(announcement)
      expect(helper.company_announcement_public_path).to eq('public_path')
    end
  end

  describe '#company_announcement_path' do
    let(:user) { double('User', role: role) }

    before do
      allow(helper).to receive(:current_user).and_return(user)
    end

    context 'when the user is a customer' do
      let(:role) { double('Role', customer?: true) }

      it 'returns the latest company announcement path' do
        announcement = double('SystemParameter', value_text: 'announcement_path')
        allow(SystemParameter).to receive_message_chain(:available, :company_announcement, :order, :limit, :first).and_return(announcement)
        expect(helper.company_announcement_path).to eq('announcement_path')
      end
    end

    context 'when the user is not a customer' do
      let(:role) { double('Role', customer?: false) }

      it 'returns an empty string' do
        expect(helper.company_announcement_path).to eq('')
      end
    end
  end

  describe '#partner_announcement_path' do
    let(:user) { double('User', role: role) }

    before do
      allow(helper).to receive(:current_user).and_return(user)
    end

    context 'when the user is a partner' do
      let(:role) { double('Role', partner?: true) }

      it 'returns the latest partner announcement path' do
        announcement = double('SystemParameter', value_text: 'partner_announcement_path')
        allow(SystemParameter).to receive_message_chain(:available, :partner_announcement, :order, :limit, :first).and_return(announcement)
        expect(helper.partner_announcement_path).to eq('partner_announcement_path')
      end
    end

    context 'when the user is not a partner' do
      let(:role) { double('Role', partner?: false) }

      it 'returns an empty string' do
        expect(helper.partner_announcement_path).to eq('')
      end
    end
  end
end
