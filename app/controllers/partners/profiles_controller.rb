# frozen_string_literal: true

class Partners::ProfilesController < Partners::ApplicationController
  before_action :set_profile, only: %i[edit update destroy]

  def index
    @profiles = current_user.profiles.load_async
  end

  def new
    @profile = current_user.profiles.build
  end

  def edit; end

  def create
    @profile = current_user.profiles.build(params_create)
    if @profile.save
      redirect_to partners_recreations_path, notice: t('action_messages.created', model_name: Profile.model_name.human)
    else
      render :new
    end
  end

  def update
    if @profile.update(params_create)
      redirect_to partners_profiles_path, notice: t('action_messages.updated', model_name: Profile.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @profile.destroy
    redirect_to partners_profiles_path, notice: t('action_messages.deleted', model_name: Profile.model_name.human)
  end

  private

  def set_profile
    @profile = current_user.profiles.find(params[:id])
  end

  def params_create
    params.require(:profile).permit(:name, :title, :position, :description, :image)
  end
end
