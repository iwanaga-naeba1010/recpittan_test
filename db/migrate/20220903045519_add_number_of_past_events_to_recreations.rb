class AddNumberOfPastEventsToRecreations < ActiveRecord::Migration[7.0]
  def change
    add_column :recreations, :number_of_past_events, :integer, default: 0, null: false
  end
end
