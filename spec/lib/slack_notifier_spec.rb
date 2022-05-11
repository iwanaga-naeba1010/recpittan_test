# frozen_string_literal: true

require 'rails_helper'

require 'slack_notifier'

RSpec.describe SlackNotifier do
  describe 'SlackNotifier in /app/lib' do
    it 'has a constructor' do
      instance = SlackNotifier.new(channel: '#料金お問い合わせ')
      expect(instance).not_to eq nil
    end

    pending do
      it 'sends a message' do
        instance = SlackNotifier.new(channel: '#料金お問い合わせ')
        req = instance.send('rspec', 'rspecでslackのテストを実行しています')
        expect(req.first.code).to eq '200'
      end
    end
  end
end
