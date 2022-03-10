# frozen_string_literal: true

ActiveAdmin.register_page 'Invoices' do
  menu priority: 1, label: proc { '請求書CSV生成' }

  content title: proc { '請求書CSV生成' } do
    div class: 'blank_slate_container', id: 'dashboard_default_message' do
      span class: 'blank_slate' do
        span I18n.t('active_admin.dashboard_welcome.welcome')
        small I18n.t('active_admin.dashboard_welcome.call_to_action')
      end
    end

    columns do
      column do
        panel 'Info' do
          button_to 'CSVの生成実行', admin_invoices_path, { data: { confirm: 'CSV生成を行うと完了statusから請求書発行済みに変更となりますがよろしいですか？' } }
        end
      end
    end
  end

  controller do
    def create
      # TODO(okubo): ここで案件を切り替えたりする
      redirect_to root_path
    end
  end
end
