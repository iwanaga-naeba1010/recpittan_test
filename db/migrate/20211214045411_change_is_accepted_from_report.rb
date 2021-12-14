class ChangeIsAcceptedFromReport < ActiveRecord::Migration[6.1]
  def change
    remove_column :reports, :is_accepted
    add_column :reports, :status, :integer
  end
end
