# # frozen_string_literal: true

# class SharingMailer < ApplicationMailer
#   def notify
#     @sharing = params[:sharing]
#     @user = params[:user]
#     @consultant_user = @sharing.consultant_user
#     # TODO, routeがないのでgoogleをテストとして入れている
#     @url = sharing_url(@sharing.id)

#     @user_type = 'consultant'
#     @answered_by = @consultant_user.consultant_company
#     subject = '【HRbase PRO】新着記事のお知らせ'

#     mail from: 'no-reply@flucle.co.jp', to: @user.email, subject: subject
#   end
# end
