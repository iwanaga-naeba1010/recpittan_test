# frozen_string_literal: true

class Partners::RecreationsController < Partners::ApplicationController
  before_action :set_recreation, only: %i[show edit update]
  before_action :set_tags, only: %i[new edit]

  def index
    @recreations = current_user.recreations
  end

  def show; end

  def new
    @recreation = current_user.recreations.build
  end

  def create
    @recreation = current_user.recreations.build(params_create)
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

  def edit; end

  def complete_final_check; end

  private

  def set_recreation
    @recreation = current_user.recreations.find(params[:id])
  end

  def set_tags
    tags = Tag.all.to_a
    @events = tags.map { |tag| tag if tag.kind == :tag }.compact
    @categories = tags.map { |tag| tag if tag.kind == :category }.compact
    @targets = tags.map { |tag| tag if tag.kind == :target }.compact
  end

  def params_create
    params.require(:recreation).permit(
      :title, :second_title, :minutes, :description,
      :flow_of_day, :borrow_item, :bring_your_own_item, :extra_information, :youtube_id,
      :capacity, :instructor_amount, :instructor_material_amount,
      :instructor_name, :instructor_title, :instructor_description, :instructor_image,
      :is_online, :is_public, :additional_facility_fee,
      { tag_ids: [] }
    )
  end
end
