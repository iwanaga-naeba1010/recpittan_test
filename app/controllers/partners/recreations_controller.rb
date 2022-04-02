# frozen_string_literal: true

class Partners::RecreationsController < Partners::ApplicationController
  before_action :set_recreation, only: %i[show edit destroy]

  def index
    @recreations = current_user.recreations
  end

  def show; end

  def new
    @recreeation = current_user.recreations.build
  end

  def create
    @recreation = Recreation.new(params_create)
    if @recreation.save
      redirect_to partners_recreation_path(@recreation), notice: 'レクリエーションを追加しました！'
    else
      render :new
    end
  end

  def update
    if @recreation.update(params_create)
      redirect_to partners_recreation_path(@recreation), notice: 'レクリエーションを更新しました！'
    else
      render :edit
    end
  end

  def complete_final_check; end

  private

  def set_recreation
    @recreation = current_user.recreations.find(params[:id])
  end

  def params_create
    params.require(:order).permit(:status, :is_accepted, :start_at)
  end
end
