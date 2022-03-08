# frozen_string_literal: true

ActiveAdmin.register Orders::UnreportedCompletedToInProgress do
  actions :all, except: %i[show destroy]
  menu parent: '強制執行モード'

  index do
    id_column

    column(:user) { |order| link_to order.user.company.facility_name, admin_company_path(order.user.company.id) }
    column :recreation
    column :start_at
    actions
  end

  form do |f|
    f.semantic_errors
    f.actions
  end

  controller do
    def update
      order = Order.find(params[:id].to_i)
      # NOTE(okubo): 本来statusは自動で切り替わるが、ここは本当に強制的なので注意してください
      order.update!(start_at: nil, is_accepted: false, status: :in_progress)

      SlackNotifier
        .new(channel: '#アクティブチャットスレッド')
        .send('管理画面から「終了報告未→相談中」の強制執行を行いました', "管理画面案件URL：#{admin_order_url(order.id)}")
      redirect_to admin_order_path(order.id)
    end
  end
end
