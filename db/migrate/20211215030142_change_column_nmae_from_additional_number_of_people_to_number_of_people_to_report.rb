class ChangeColumnNmaeFromAdditionalNumberOfPeopleToNumberOfPeopleToReport < ActiveRecord::Migration[6.1]
  def change
    remove_column :reports, :additional_number_of_people
  end
end
