class RemovePrefecturesFromRecreation < ActiveRecord::Migration[7.0]
  def change
    remove_column :recreations, :prefectures
  end
end
