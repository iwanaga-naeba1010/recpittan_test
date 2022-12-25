# frozen_string_literal: true

ActiveAdmin.register CompanyMemo do
  menu false # NOTE: サイドバーに表示しない設定
  actions :create
  belongs_to :company
  permit_params(
    %i[company_id body]
  )

  controller do
    def create
      memo = CompanyMemo.new(
        company_id: params[:company_memo][:company_id].to_i,
        body: params[:company_memo][:body]
      )
      memo.save
      # TODO: 動的にid入れる
      redirect_to admin_company_path(params[:company_memo][:company_id].to_i)
    end
  end
end
