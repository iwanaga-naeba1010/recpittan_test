class OrderDateTypeChange < ActiveRecord::Migration[6.1]
  def change
    change_column :order_dates, :year, :string
    change_column :order_dates, :month, :string
    change_column :order_dates, :date, :string
    change_column :order_dates, :start_hour, :string
    change_column :order_dates, :start_minute, :string
    change_column :order_dates, :end_hour, :string
    change_column :order_dates, :end_minute, :string
  end
end
