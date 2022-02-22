# frozen_string_literal: true

ActiveAdmin.register EmailTemplate do
  permit_params(%i[explanation title body signature])
  actions :all

  index do
    id_column
    column :title

    actions
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :explanation
      f.input :title
      f.input :body
      f.input :signature
    end

    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params
  #
  # or
  #
  # permit_params do
  #   permitted = []
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
