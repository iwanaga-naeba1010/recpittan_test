# frozen_string_literal: true

ActiveAdmin.register UserMemo do
  menu false # NOTE: サイドバーに表示しない設定
  actions :create
  belongs_to :user
  permit_params(
    %i[user_id body]
  )

  controller do
    def create
      memo = UserMemo.new(
        user_id: params[:user_memo][:user_id].to_i,
        body: params[:user_memo][:body]
      )
      memo.save
      # TODO: 動的にid入れる
      redirect_to admin_user_path(params[:user_memo][:user_id].to_i)
    end
  end
end
