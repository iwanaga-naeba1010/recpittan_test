# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register RecreationPlan do
  permit_params(
    %i[
      code release_status title adjustment_fee company_id
    ],
    tag_ids: [],
    recreation_recreation_plans_attributes: %i[id recreation_id month _destroy]
  )
  actions :all

  filter :code
  filter :title

  index do
    id_column
    column :code
    column(:release_status, &:release_status_text)
    column :title
    column :adjustment_fee
    column :company do |recreation_plan|
      recreation_plan.facility_name
    end

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
          row :adjustment_fee
          row 'Company' do |recreation_plan|
            recreation_plan.facility_name
          end

          row :created_at
          row :updated_at

          panel t('activerecord.models.recreation_recreation_plan') do
            table_for recreation_plan.recreation_recreation_plans.order(month: :asc) do
              column :recreation
              column :month
            end
          end

          panel 'タグ', style: 'margin-top: 30px;' do
            table_for recreation_plan.tags.plans do
              column :id
              column :name
              column :adjustment_fee
            end
          end
        end
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :title
      f.input :release_status, as: :select, collection: RecreationPlan.release_status.values.map { |i| [i.text, i] }
      f.input :company, as: :select, collection: Company.all.map { |company| [company.facility_name, company.id] }
    end

    f.input :tags, label: 'タグ', as: :check_boxes, collection: Tag.plans.all

    f.inputs t('activerecord.models.recreation_recreation_plan') do
      f.has_many :recreation_recreation_plans, heading: false, allow_destroy: true, new_record: true do |ff|
        ff.input :recreation_id, as: :select, collection: Recreation.all.map { |recreation| [recreation.title, recreation.id] }
        ff.input :month, as: :select, collection: 1..12, require: true
      end
    end

    f.actions
  end
end
# rubocop:enable Metrics/BlockLength
