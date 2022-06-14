# frozen_string_literal: true

ActiveAdmin.register Chat do
  permit_params { Chat.attribute_names.map(&:to_sym) }
  actions :all, except: %i[edit update]

  index do
    id_column
    column(:order_id) { |chat| link_to chat.order.id, admin_order_path(chat.order.id) }
    column(:user) do |chat|
      link_to chat.user.company&.facility_name, admin_company_path(chat.order.user.company.id)
    end
    column :message do |text|
      text.message.truncate(20)
    end
    column :is_read

    actions
  end

  show do
    attributes_table do
      row :id
      row(:order_id) { |chat| link_to chat.order.id, admin_order_path(chat.order.id) }
      row :user
      row :message
      row :is_read
      row(:file) do |chat|
        image_tag chat&.file&.to_s, width: 50, height: 50
      end
      row :created_at
      row :updated_at
    end
  end

  controller do
    # NOTE(okubo): chatは管理者が施設として送信しています
    # なのでメール送信等特殊な実装となっているので修正は控えてください
    def create
      order = Order.find(permitted_params[:chat][:order_id])
      chat = order.chats.build(
        user_id: order.user.id,
        message: permitted_params[:chat][:message]
      )
      chat.save

      PartnerChatMailer.notify(order: order).deliver_now
      SlackNotifier.new(channel: '#アクティブチャットスレッド').send('管理画面からチャット送信を行いました', "管理画面案件URL：#{admin_order_url(order.id)}")
      redirect_to admin_order_path(order.id)
    end
  end
end
