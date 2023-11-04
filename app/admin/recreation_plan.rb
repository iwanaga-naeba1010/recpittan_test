# frozen_string_literal: true

ActiveAdmin.register RecreationPlan do
  permit_params(
    %i[
      code release_status title
    ]
  )
  actions :all

  filter :code
  filter :title

  index do
    id_column
    column :code
    column(:release_status, &:release_status_text)
    column :title

    actions
  end

  show do
    tabs do
      tab '詳細' do
        attributes_table do
          row :id
          row :code
          row(:release_status, &:release_status_text)
          row :title

          row :created_at
          row :updated_at
        end
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :title
      f.input :release_status, as: :select, collection: RecreationPlan.release_status.values.map { |i| [i.text, i] }
    end

    f.inputs t('activerecord.models.recreation_recreation_plan') do
      f.has_many :recreation_recreation_plans, heading: false, allow_destroy: true, new_record: true do |ff|
        ff.input :recreation_id, as: :select, collection: Recreation.all.map { |recreation| [recreation.title, recreation.id] }
        ff.input :month, as: :select, collection: 1..12, require: true
      end
    end

    f.actions
  end
end
