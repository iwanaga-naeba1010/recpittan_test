class AddTotalAdditionalFeeToRecreation < ActiveRecord::Migration[6.1]
  def change
    add_column :recreations, :additional_facility_fee, :integer, default: 2000
  end
end
