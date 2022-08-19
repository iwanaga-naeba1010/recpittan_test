# frozen_string_literal: true

ActiveAdmin.register_page 'caches' do
  menu priority: 1, label: proc { 'キャッシュのクリア' }

  content title: proc { 'キャッシュのクリア' } do
    columns do
      column do
        panel 'キャッシュのクリア' do
          button_to 'キャッシュのクリア', admin_caches_path
        end
      end
    end
  end

  controller do
    def create
      Rails.cache.clear
      redirect_to admin_caches_path, notice: t('action_messages.cache_clear')
    end
  end
end
