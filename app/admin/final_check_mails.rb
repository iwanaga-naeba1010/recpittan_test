# frozen_string_literal: true

require 'rake'

ActiveAdmin.register_page 'final_check_mails' do
  menu priority: 1, label: proc { '最終確認メール' }

  content title: proc { '最終確認メール' } do
    columns do
      column do
        panel '最終確認メール' do
          button_to '送信', admin_final_check_mails_path
        end
      end
    end
  end

  controller do
    def create
      Rails.application.load_tasks
      Rake::Task['send_final_check_mail:run'].invoke
      redirect_to admin_final_check_mails_path, notice: 'メール送信しました！'
    end
  end
end
