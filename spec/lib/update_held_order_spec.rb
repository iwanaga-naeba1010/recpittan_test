# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe 'update_held_order' do
  let(:partner) { create :user, :with_recreations }
  let(:customer) { create :user, :with_customer }
  let(:order) { create :order, recreation_id: partner.recreations.first.id, user_id: customer.id }

  before(:all) do
    # rakeタスクをloadと実行する環境の準備
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake.application.rake_require 'tasks/update_held_order'
    Rake::Task.define_task(:environment)

    # NOTE(okubo): taskでmailも送信するので追加
    Rails.application.load_tasks
    Rake::Task['load_email_templates:run'].invoke
  end

  before(:each) do
    @rake[task].reenable
  end

  describe 'update_held_order in /lib' do
    let(:task) { 'update_held_order:run' }

    it 'calls update_held_order:run task' do
      expect(@rake[task].invoke).to be_truthy
    end

    it 'updates order status when order held' do
      current_time = Time.current
      order.update(start_at: current_time + 1, is_accepted: true)
      sleep 3
      @rake[task].invoke

      # NOTE: reloadしないと最新にできないので明示的にreload
      order.reload

      expect(order.status).to eq 'unreported_completed'
    end
  end
end
