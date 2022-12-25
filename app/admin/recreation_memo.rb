# frozen_string_literal: true

ActiveAdmin.register RecreationMemo do
  menu false # NOTE: サイドバーに表示しない設定
  actions :create
  belongs_to :recreation
  permit_params(
    %i[recreation_id body]
  )

  controller do
    def create
      memo = RecreationMemo.new(
        recreation_id: params[:recreation_memo][:recreation_id].to_i,
        body: params[:recreation_memo][:body]
      )
      memo.save
      # TODO: 動的にid入れる
      redirect_to admin_recreation_path(params[:recreation_memo][:recreation_id].to_i)
    end
  end
end
