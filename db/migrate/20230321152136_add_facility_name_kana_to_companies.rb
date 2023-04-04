class AddFacilityNameKanaToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :facility_name_kana, :string
  end
end
