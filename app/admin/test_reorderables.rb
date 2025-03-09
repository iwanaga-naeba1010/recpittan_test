# frozen_string_literal: true

ActiveAdmin.register TestReorderable do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :code, :release_status, :adjustment_fee, :company_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :code, :release_status, :adjustment_fee, :company_id, :disporder]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  config.sort_order = ''
  config.paginate   = false

  reorderable

  actions :index, :edit, :update

  filter :code
  filter :title

  index as: :reorderable_table do
    column :disporder
    column :code
    column(:release_status, &:release_status_text)
    column :title
    column :adjustment_fee
    column :company, &:facility_name

    actions
  end

  controller do
    before_update :change_disporder_by_code

    private

    def scoped_collection
      super.order(disporder: :asc, updated_at: :desc)
    end

    def change_disporder_by_code(resource)
      return unless resource.code_changed? && resource.valid?

      test_reorderable_ids = RecreationPlan.order(disporder: :asc, updated_at: :desc).pluck(:id)
      resource_index       = test_reorderable_ids.find_index(resource.id).to_i
      code_param           = params.dig(:test_reorderable, :code)
      resource.disporder   = code_param.to_i * TestReorderable::DISPORDER_STEP
      resource.disporder += resource_index.next unless resource_index.zero?
    end
  end
end
