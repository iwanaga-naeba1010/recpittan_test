# frozen_string_literal: true

ActiveAdmin.register Evaluation do
  permit_params(%i[is_public])
  actions :all, except: [:destroy]

  index do
    id_column
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
      f.input :is_public, as: :select, collection: Evaluation.is_public.values.map { |i| [i.text, i] }
    end

    f.actions
  end
end
