# frozen_string_literal: true

ActiveAdmin.register TopBanner do
  permit_params(
    :image, :url, :start_date, :end_date
  )
  filter :id
  filter :start_date
  filter :end_date

  actions :all

  index do
    id_column
    column :start_date
    column :end_date
    column(:image) do |top_banner|
      image_tag top_banner&.image&.to_s, width: 50, height: 50
    end

    actions
  end

  show do
    attributes_table do
      row :id
      row(:image) do |top_banner|
        image_tag top_banner&.image&.to_s, width: 50, height: 50
      end
      row :start_date
      row :end_date
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :image
      f.input :url
      f.input :start_date, as: :datepicker
      f.input :end_date, as: :datepicker
    end

    f.actions
  end
end
