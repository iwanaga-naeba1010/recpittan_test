# frozen_string_literal: true

ActiveAdmin.register ChannelPlanSubscriber do
  permit_params(
    :kind, :company_id
  )

  filter :company

  index do
    id_column
    column :company
    column '施設名', :company_facility_name do |resource|
      resource.company.facility_name
    end
    column(:kind, &:kind_text)
    actions
  end

  show do
    tabs do
      tab '詳細' do
        attributes_table do
          row :id
          row :company
          row '施設名', :company_facility_name do |resource|
            resource.company.facility_name
          end
          row(:kind, &:kind_text)
          row :created_at
          row :updated_at
        end
      end
      tab 'メモ' do
        render 'admin/channel_plan_subscribers/memo', channel_plan_subscriber:
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      companies = Company.without_channel_subscribe.map { |c| ["#{c.facility_name} (#{c.id})", c.id] }
      f.input :company, as: :select, collection: companies
      f.input :kind, as: :select, collection: ChannelPlanSubscriber.kind.values.map { |val| [val.text, val] }
      f.input :status, as: :select, collection: ChannelPlanSubscriber.status.values.map { |val| [val.text, val] }
    end

    f.actions
  end
end
