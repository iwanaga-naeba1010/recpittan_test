class ChangeColumnTypeToCompnayNursingCareLevel < ActiveRecord::Migration[7.0]
  def change
    change_column :companies, :nursing_care_level, :string
  end
end
