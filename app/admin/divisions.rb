# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
ActiveAdmin.register Division do
  permit_params(
    %i[
      classname code disporder i18n_class i18n_flag key memo valuedate valueint valuetext
    ]
  )

  actions :all
  menu parent: 'システム管理'

  index do
    id_column
    column :classname
    column :code
    column :disporder
    column :i18n_class
    column :i18n_flag
    column :key
    column :memo
    column :valuedate
    column :valueint
    column :valuetext
    column :created_at
    column :updated_at
  end

  show do
    tabs do
      tab '詳細' do
        attributes_table do
          row :id
          row :classname
          row :code
          row :disporder
          row :i18n_class
          row :i18n_flag
          row :key
          row :memo
          row :valuedate
          row :valueint
          row :valuetext
          row :created_at
          row :updated_at
        end
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs do
      f.input :classname
      f.input :code
      f.input :disporder
      f.input :i18n_class
      f.input :i18n_flag
      f.input :key
      f.input :memo
      f.input :valuedate, as: :datetime_picker
      f.input :valueint
      f.input :valuetext
    end

    f.actions
  end

  controller do
    def create
      super do |success, _failure|
        success.html { redirect_to resource_path(resource) } # 作成後に詳細画面へリダイレクト
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
