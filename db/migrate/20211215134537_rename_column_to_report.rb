class RenameColumnToReport < ActiveRecord::Migration[6.1]
  def change
    rename_column :reports, :facility_count, :number_of_facilities
  end
end
