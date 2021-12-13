class AddAdditionalNumberOfPeopleToReport < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :additional_number_of_people, :integer
  end
end
