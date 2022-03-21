class AddColumnsToCompanyAndUser < ActiveRecord::Migration[6.1]
  def change
    add_column :companies, :genre, :integer, default: 0

    add_column :companies, :feature, :text
    add_column :companies, :url, :string
    add_column :companies, :capacity, :integer
    add_column :companies, :nursing_care_level, :integer
    add_column :companies, :request, :text

    add_column :users, :title, :string

    remove_column :companies, :address
  end
end
