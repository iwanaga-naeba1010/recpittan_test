# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Evaluation do
  permit_params(
    %i[
      ingenuity communication smoothness price want_to_order_agein message is_public
    ]
  )
  actions :all, except: [:destroy]

  csv do
    column :id
    column('レク名') do |evaluation|
      evaluation.report.order.recreation.title
    end
    column('PT名') do |evaluation|
      evaluation.report.order.recreation.user.username
    end
    column('施設名') do |evaluation|
      evaluation.report.order.user.company.name
    end
    column(:ingenuity, &:ingenuity_text)
    column(:communication, &:communication_text)
    column(:smoothness, &:smoothness_text)
    column(:price, &:price_text)
    column(:want_to_order_agein, &:want_to_order_agein_text)
    column :message
    column(:is_public, &:is_public_text)
  end

  index do
    id_column
    column :report
    column('レク名') do |evaluation|
      evaluation.report.order.recreation.title
    end
    column('PT名') do |evaluation|
      evaluation.report.order.recreation.user.username
    end
    column('施設名') do |evaluation|
      evaluation.report.order.user.company.name
    end
    column(:ingenuity, &:ingenuity_text)
    column(:communication, &:communication_text)
    column(:smoothness, &:smoothness_text)
    column(:price, &:price_text)
    column(:want_to_order_agein, &:want_to_order_agein_text)
    column :message do |text|
      text.message.truncate(20)
    end
    column(:is_public, &:is_public_text)

    actions
  end

  show do
    attributes_table do
      row :id
      row(:ingenuity, &:ingenuity_text)
      row(:communication, &:communication_text)
      row(:smoothness, &:smoothness_text)
      row(:price, &:price_text)
      row(:want_to_order_agein, &:want_to_order_agein_text)
      row :message
      row :other_message
      row(:is_public, &:is_public_text)

      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :ingenuity, as: :select, collection: Evaluation.ingenuity.values.map { |i| [i.text, i] }
    end
    f.inputs do
      f.input :communication, as: :select, collection: Evaluation.communication.values.map { |i| [i.text, i] }
    end
    f.inputs do
      f.input :smoothness, as: :select, collection: Evaluation.smoothness.values.map { |i| [i.text, i] }
    end
    f.inputs do
      f.input :price, as: :select, collection: Evaluation.price.values.map { |i| [i.text, i] }
    end
    f.inputs do
      f.input :want_to_order_agein, as: :select, collection: Evaluation.want_to_order_agein.values.map { |i| [i.text, i] }
    end
    f.input :message
    f.inputs do
      f.input :is_public, as: :select, collection: Evaluation.is_public.values.map { |i| [i.text, i] }
    end

    f.actions
  end
end
# rubocop:enable Metrics/BlockLength
