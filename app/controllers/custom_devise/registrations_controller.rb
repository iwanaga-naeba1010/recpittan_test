# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter
class CustomDevise::RegistrationsController < Devise::RegistrationsController
  include Recaptcha::Adapters::ControllerMethods
  include Recaptcha::Adapters::ViewMethods
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super do
      company = Company.new
      resource.company = company
    end
  end

  # POST /resource
  def edit
    @tags = Tags::Rental.all
    super
  end

  # GET /resource/edit
  def create
    unless verify_recaptcha
      build_resource(sign_up_params)
      return render 'new'
    end

    super do
      # TODO(okubo): SQL2回発行していることになっているので、解消したい
      resource.update(
        username: params[:user][:company_attributes][:person_in_charge_name],
        username_kana: params[:user][:company_attributes][:person_in_charge_name_kana]
      )
    end

    return if resource.id.blank?

    message = <<~MESSAGE
      事業所名： #{resource.company.facility_name}
      管理画面案件URL： #{admin_company_url(resource.company.id)}
    MESSAGE
    SlackNotifier.new(channel: '#アクティブチャットスレッド').send('新規登録がありました', message)
  end

  # PUT /resource
  # def update
  #   super
  #   # rescue StandardError => e
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [
        :role, :title,
        { company_attributes: %i[
          name facility_name person_in_charge_name person_in_charge_name_kana prefecture genre tel
        ] }
      ]
    )
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [
        company_attributes: [
          :id, :name, :facility_name, :person_in_charge_name, :person_in_charge_name_kana,
          :zip, :prefecture, :city, :street, :building, :tel, :genre, :url, :capacity, :feature, :nursing_care_level, :request,
          { tag_ids: [] }
        ]
      ]
    )
  end

  # ユーザー情報更新時にパスワードが変わらないようにする他mのところ
  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  def after_update_path_for(_resource)
    edit_user_registration_path
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(_resource)
    registration_thanks_path
  end
end
# rubocop:enable Rails/LexicallyScopedActionFilter
