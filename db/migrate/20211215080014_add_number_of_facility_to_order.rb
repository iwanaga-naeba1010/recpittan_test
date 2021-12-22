class AddNumberOfFacilityToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :number_of_facilities, :integer
  end
end
